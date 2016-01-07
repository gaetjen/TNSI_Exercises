function [P4, X4] = RespPDF( sin, xout )

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% input: monotonically increasing stimulus vector sin
%        monotonically increasing response vector xout

% output: matrix P4 joint probability given X and S, size( 4, numel(xout), numel(sin) ) 

%         matrix X4 expected X given S, size( 4, numel(sin))

global Rmax Rdark SA SB SC SD gamma2A gamma2B gamma2C gamma2D;


% set global variables

SetParams;


% tuning curves

Rout = nan( 4, numel(sin) );

routA = Rdark + Rmax * exp( -(sin-SA).^2 / gamma2A );
routB = Rdark + Rmax * exp( -(sin-SB).^2 / gamma2B );
routC = Rdark + Rmax * exp( -(sin-SC).^2 / gamma2C );
routD = Rdark + Rmax * exp( -(sin-SD).^2 / gamma2D );

% sin2 = sin.^2;

% routA = Rdark + Rmax * sin2 ./ ( SA^2 + sin2 );
% routB = Rdark + Rmax * sin2 ./ ( SB^2 + sin2 );
% routC = Rdark + Rmax * sin2 ./ ( SC^2 + sin2 );
% routD = Rdark + Rmax * sin2 ./ ( SD^2 + sin2 );

[ROUTA, XOUT] = meshgrid( routA, xout );
[ROUTB, XOUT] = meshgrid( routB, xout );
[ROUTC, XOUT] = meshgrid( routC, xout );
[ROUTD, XOUT] = meshgrid( routD, xout );


% response variability

PA = poisspdf( XOUT, ROUTA );
PB = poisspdf( XOUT, ROUTB );
PC = poisspdf( XOUT, ROUTC );
PD = poisspdf( XOUT, ROUTD );

% normalize to probabilities

PA = PA ./ sum(sum(PA));

PB = PB ./ sum(sum(PB));

PC = PC ./ sum(sum(PC));

PD = PD ./ sum(sum(PD));

EXA = sum( XOUT .* PA, 1 ) ./ sum( PA, 1 );

EXB = sum( XOUT .* PB, 1 ) ./ sum( PB, 1 );

EXC = sum( XOUT .* PC, 1 ) ./ sum( PC, 1 );

EXD = sum( XOUT .* PD, 1 ) ./ sum( PD, 1 );

P4 = nan( 4, numel(xout), numel(sin) );

X4 = nan( 4, numel(sin) );

P4(1,:,:) = PA;
P4(2,:,:) = PB;
P4(3,:,:) = PC;
P4(4,:,:) = PD;

X4(1,:)   = EXA;
X4(2,:)   = EXB;
X4(3,:)   = EXC;
X4(4,:)   = EXD;

%% 
