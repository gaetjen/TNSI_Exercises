function ShowRespPDF( sin, xout, PN_XandS, EXN_S )

fs = 12;

clr  = ['r.';'g.';'b.';'k.'];

figure;
for i=1:4
        
    subplot(2,2,i);
    hold on;
    contour( sin, xout, squeeze( PN_XandS(i,:,:)),'LineWidth',2 );
%    plot( sA, Xmean(i,:), clr(i,:) );
    plot( sin, EXN_S(i,:), clr(i,:) );   
    
    hold off;
    axis 'square';
    set( gca, 'FontSize', fs );
    xlabel('s', 'FontSize', fs, 'FontWeight','b' );
    ylabel('x', 'FontSize', fs );
    title( ['Neuron ' num2str(i,'%d')], 'FontSize', fs+2,'FontWeight','b','FontName','Times New Roman' );
    set(gca,'FontName','Times New Roman','FontSize',fs,'FontWeight','bold','LineWidth',2)
end

return;