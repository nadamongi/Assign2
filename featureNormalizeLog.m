function [X_norm] = featureNormalizeLog(X)
for w=2:length(X(1,:));
 if max(abs(X(:,w)))~=0
    %X_norm(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    X_norm(:,w)=X(:,w)/max((X(:,w)));
 end

end


