function myspectrogram(x, alen, ulen)
% x is the speech vector
% alen is the analysis frame length, ulen is the update length
Fs = 8000;
N = length(x);
time = 0:1/Fs:N/Fs - 1/Fs;
naf = floor((N-alen+ulen)/ulen); % Number of analysis frames
n1 = 1; n2 = alen;
S = zeros(alen/2+1, naf);

    for n=1:naf % Counter over analysis frames
        xf = x(n1:n2);
        timef = time(n1:n2);

        subplot(2, 1, 1);
        plot(timef, xf); 
        title('Time domain signal'); xlabel('Time in sec'); ylabel('magnitude');
        axis([timef(1) timef(end) min(x) max(x)]);

        subplot(2, 1, 2);
        xf2 = xf.*hanning(alen);
        X = fft(xf2);
        S(:,n) = 10*log10(abs(X(1:alen/2+1)).^2); 
        plot(0:Fs/alen:Fs/2, 10*log10(abs(X(1:alen/2+1)).^2)); 
        title('Corresponding spectrum'); xlabel('Frequency in Hz'); ylabel('Power in dB');

        pause(0.05); frame(n) = getframe(gcf); 
        n1 = n1 + ulen;
        n2 = n2 + ulen;
    end

video = VideoWriter('new_play.mp4', 'MPEG-4');
video.FrameRate = 10;
open(video)
writeVideo(video,frame)
close(video)

end
