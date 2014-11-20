% PROGRESS  Display progress of a loop
%   Before entering the loop, perform a "tic" operation and pass its value
%   to progress as an input. This will help estimate the time spent so far
%   and the time spent per loop iteration, without using global variables.
%   The progress function call should be placed at the end of the loop
%   iteration. 
% 
%   PROGRESS(msg, iter, nIter, ticStart, dispStep)
% 
% INPUT:
%   msg:  message to display
%   iter: current iteration of the loop
%   nIter:total number of loop iterations
%   ticStart: 
%   
%   EXAMPLE:
%   --------------------------------------
%   ticStart = tic; 
%   for i=1:nIter
%       .
%       .
%       .
%       progress(msg, i, nIter, ticStart)
%   end
% 
% Stavros Tsogkas, <stavros.tsogkas@ecp.fr>
% Last update: November 2014

function progress(msg, iter, nIter, ticStart, dispStep)
    if iter == nIter
        fprintf('Done! '); toc(ticStart);
        return
    end
    
    if nargin < 5, dispStep = 2; end   % display progress (approximately)
    timeElapsed = toc(ticStart);       % every dispStep seconds
    timePerIter = timeElapsed / iter;
    timeLeft    = (nIter - iter) * timePerIter;
    
    if dispStep
        if  (mod((iter-1)*timePerIter, dispStep) - mod(iter*timePerIter, dispStep)) > 0
            msg = [msg, sprintf(' %.1f%%. ETR: ', 100*iter/nIter)];
            disp(addTimeLeft(msg,timeLeft));
        end
    else
        msg = [msg, sprintf('Iteration %d/%d. ETR: ',iter,nIter)];
        disp(addTimeLeft(msg,timeLeft));
    end
end
    
    
function msg = addTimeLeft(msg, timeLeft) 
    if timeLeft / 3600 > 1
        msg = [msg, sprintf('%.1f h',   timeLeft / 3600)];
    elseif timeLeft / 60 > 1
        msg = [msg, sprintf('%.1f min', timeLeft / 60)];
    else
        msg = [msg, sprintf('%.1f sec', timeLeft)];
    end
end
