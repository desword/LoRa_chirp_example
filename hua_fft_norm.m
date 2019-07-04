function hua_fft_norm(y,fs,style,varargin)
%µ±style=1,»­·ùÖµÆ×£»µ±style=2,»­¹¦ÂÊÆ×;µ±style=ÆäËûµÄ£¬ÄÇÃ´»¨·ùÖµÆ×ºÍ¹¦ÂÊÆ×
%µ±style=1Ê±£¬»¹¿ÉÒÔ¶àÊäÈë2¸ö¿ÉÑ¡²ÎÊý
%¿ÉÑ¡ÊäÈë²ÎÊýÊÇÓÃÀ´¿ØÖÆÐèÒª²é¿´µÄÆµÂÊ¶ÎµÄ
%µÚÒ»¸öÊÇÐèÒª²é¿´µÄÆµÂÊ¶ÎÆðµã
%µÚ¶þ¸öÊÇÐèÒª²é¿´µÄÆµÂÊ¶ÎµÄÖÕµã
%ÆäËûstyle²»¾ß±¸¿ÉÑ¡ÊäÈë²ÎÊý£¬Èç¹ûÊäÈë·¢ÉúÎ»ÖÃ´íÎó
nfft= 2^nextpow2(length(y));%ÕÒ³ö´óÓÚyµÄ¸öÊýµÄ×î´óµÄ2µÄÖ¸ÊýÖµ£¨×Ô¶¯½øËã×î¼ÑFFT²½³¤nfft£©
%nfft=1024;%ÈËÎªÉèÖÃFFTµÄ²½³¤nfft
  y=y-mean(y);%È¥³ýÖ±Á÷·ÖÁ¿
y_ft=fft(y,nfft);%¶ÔyÐÅºÅ½øÐÐDFT£¬µÃµ½ÆµÂÊµÄ·ùÖµ·Ö²¼
y_p=((y_ft.*conj(y_ft)))/nfft;%conj()º¯ÊýÊÇÇóyº¯ÊýµÄ¹²éî¸´Êý£¬ÊµÊýµÄ¹²éî¸´ÊýÊÇËû±¾Éí¡£
% y_p(1)=mean(y_p);y_p(2)=mean(y_p);
y_f=fs*(0:nfft/2-1)/nfft;%T±ä»»ºó¶ÔÓ¦µÄÆµÂÊµÄÐòÁÐ
% y_p=y_ft.*conj(y_ft)/nfft;%conj()º¯ÊýÊÇÇóyº¯ÊýµÄ¹²éî¸´Êý£¬ÊµÊýµÄ¹²éî¸´ÊýÊÇËû±¾Éí¡£
if style==1
    if nargin==3
        plot(y_f,2*abs(y_ft(1:nfft/2))/length(y)/max(abs(y_ft)),'k','linewidth',1.2);%matlabµÄ°ïÖúÀï»­FFTµÄ·½·¨
        %ylabel('·ùÖµ');xlabel('ÆµÂÊ');title('ÐÅºÅ·ùÖµÆ×');
        %plot(y_f,abs(y_ft(1:nfft/2)));%ÂÛÌ³ÉÏ»­FFTµÄ·½·¨
        ylabel('Normalized Amplitude');xlabel('Frequency /Hz');
    else
        f1=varargin{1};
        fn=varargin{2};
        ni=round(f1 * nfft/fs+1);
        na=round(fn * nfft/fs+1);
        plot(y_f(ni:na),abs(y_ft(ni:na)*2/nfft)/max(abs(y_ft)),'k','linewidth',1.2);
        ylabel('Normalized Amplitude');xlabel('Frequency /Hz');
    end
elseif style==2
            plot(y_f,y_p(1:nfft/2)/max(y_p),'k','linewidth',1.2);
            ylabel('Normalized Amplitude');xlabel('Frequency /Hz');
            
            [values, index] = max(y_p(1:nfft/2)/max(y_p));
%             disp(['test' index]);
            est_freq = y_f(index)
            values
            
            %ylabel('¹¦ÂÊÆ×ÃÜ¶È');xlabel('ÆµÂÊ');title('ÐÅºÅ¹¦ÂÊÆ×');
    else
        subplot(211);plot(y_f,2*abs(y_ft(1:nfft/2))/length(y)/max(abs(y_ft)),'k','linewidth',1.2);
%         ylabel('·ùÖµ');xlabel('ÆµÂÊ');title('ÐÅºÅ·ùÖµÆ×');
       ylabel('Normalized Amplitude');xlabel('Frequency /Hz');
        subplot(212);plot(y_f,y_p(1:nfft/2)/max(y_p),'k','linewidth',1.2);
%         ylabel('¹¦ÂÊÆ×ÃÜ¶È');xlabel('ÆµÂÊ');title('ÐÅºÅ¹¦ÂÊÆ×');
        ylabel('Normalized Amplitude');xlabel('Frequency /Hz');
end
end

