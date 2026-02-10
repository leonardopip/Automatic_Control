clear all
close all
clc

%% Modal analyis and stud of the internal stability
A = [-2 0 0;0 0 1;0 0 0];

% Need to evaluate the eigenvalues of A
eigenvalues = eig(A) %gli autovalori sono -2 0 0 ->

% Check the algebrica multiplicity of the eigenvalues
roots(minpoly(A)) % si ottiene -2 con moltiplicità 1 e sono con moltiplicità 2


%%

A = [-1 0 0;0 0 1;0 -1 0];
eigenvalues = eig(A) %gli autovalori sono -2 0 0 ->

% Check the algebrica multiplicity of the eigenvalues
roots(minpoly(A)) % si ottiene -2 con moltiplicità 1 e sono con moltiplicità 2

%%