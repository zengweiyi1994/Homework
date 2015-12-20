function [] = PlotResult(P, W, B)
  figure;
  
  % plot points
  PX = P(:, 1)';
  PY = P(:, 2)';
  plot(PX(1:3),PY(1:3), '+'); hold on;
  plot(PX(4:6),PY(4:6), 's'); hold on;
  plot(PX(7:9),PY(7:9), '*'); hold on;

  % plot decision boundary
  axis([-5 10 -5 10])
  plotLine(W(1,1), W(1,2), B(1)); hold on;
  plotLine(W(2,1), W(2,2), B(2)); hold off;
  legend('class1', 'class2', 'class3', 'decision boundary1', 'decision boundary2');
  xlabel('x');
  ylabel('y');
end

% plot line c1 * x + c2 * y + b = 0
function [] = plotLine(c1, c2, b)
  if (c2 == 0)
    SP = - b / c1;
    line([SP SP], [-20, 20]);
  else
    x = linspace(-20, 20);
    y = (-b - c1 * x) / c2;
    plot(x, y);
  end
end
P = [ 0, 0; 1, 3; 2, -1; 3, 4; 4, 4; 4, 6; 5, 0; 5, -2; 6, 0; ];
T = [ -1, -1; -1, -1; -1, -1; -1, 1; -1, 1; -1, 1; 1, -1; 1, -1; 1, -1;];

% Compute [W, B]
[W, B] = ADALINE (P, T);

disp('Weight Vector:');
disp(W);
disp('Bias:');
disp(B);

% Plot point and decision boundary
PlotResult(P, W, B);
function [W, B] = ADALINE (P, T)
  % initialize W and B
  W = [-1, -1; -1, -1];
  B = [-1; -1];
  alpha = 0.002;
  delta = 0.000000001;
  
  % finish tag indicating whether to reiterate the inputs
  finish = false;
  while not(finish)
    W_new = W;
    B_new = B;
    for i = 1:size(P, 1)
      % initialize p, t
      p = P(i,:)';
      t = T(i,:)';
    
      a = W_new * p + B_new;
      e = t - a;
      W_new = W_new + 2 * alpha * e * p';
      B_new = B_new + 2 * alpha * e;
    end
    
    if max(max(W_new-W)) < delta && max(max(B_new-B)) < delta
      finish = true;
    end
    
    W = W_new;
    B = B_new;
  end
end