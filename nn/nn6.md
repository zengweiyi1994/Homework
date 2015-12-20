###Name: Weiyi Zeng
###NetId: wzi523
###Student Id: 2910538
##Homework 5
##a:
#####code:

```
n=1000
X1 = randn(n,1);
X2 = sqrt(0.01)*randn(n,1);
X3 = sqrt(0.001)*randn(n, 1);
X = [X1'; X2'; X3'];
C = cov(X');
[V, R] = eig(C);
```
##b:
#####code:
```
function [W, W_initial] = pcaosga(X, m, gamma, alpha)
    W_initial = randn(m,size(X,1));
    W = W_initial;
    e = 0.0000001;
    i=1
    while i
        W_initial = W;
        y0 = W * X(:,1);
        u = 1/(y0'*y0);
        for k = 1:size(X, 2)
            xk = X(:,k);
            yk = W * xk;
            u = 1/ ((gamma / u) + yk'*yk);
            W = W + u*(yk*xk' - (diag(diag(yk*yk')) + alpha * tril(yk*yk', -1))*W);
        end
 
        if max(max(abs(W_initial-W))) < e
            i=0
        end
    end
end




```
#####Results:

```
% Use Oja's SGA learning rule
m=3
gamma=1
alpha=3
[W,W_initial]=pcaosga(X,m,gamma,alpha)
% The results are:
% Transpose because W has rows as the eigenvectors
W' =
    1.0000   -0.0022    0.0008
   -0.0010   -0.9994   -0.0465
    0.0009    0.0512   -1.0739

W_initial' =
    0.8706    1.5479   -1.4236
    0.3308   -0.6166   -0.1096
   -1.3479   -0.6986   -0.1027

% The computed eigenvalues are given as:
lamda1 = 
    0.9979

lamda2 = 
    0.0100

lamda3 = 
    0.0012

```
##c:
#####code:

```
function [W, W_initial] = pcasgh(X, m, gamma)
    [W, W_initial] = pcaosga(X, m, gamma, 1);
end
```
#####Results:

```
% Use Oja's GHA learning rule
m=3
gamma=1
[W,W_initial]=pcaosga(X,m,gamma,alpha)
% The results are:
% Transpose because W has rows as the eigenvectors
W' =
   -1.0000    0.0049   -0.0082
    0.0010   -1.0276    0.2346
   -0.0009   -0.0212   -0.6053

W_initial' =
   -0.3227    3.0125   -0.1149
   -0.8396    1.5008    0.3589
   -1.6606   -0.3590   -0.0121

% The computed eigenvalues are given as:
lamda1 = 
    0.9980

lamda2 = 
    0.0105

lamda3 = 
   3.8075e-04

```
##d:
#####Compare SGA and GHA:
1. with the increase of m, it runs slower

2. SGA converges much faster than GHA

3. gamma affected the performance of the two algorithms



