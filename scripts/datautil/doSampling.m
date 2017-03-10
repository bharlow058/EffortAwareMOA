function y = doSampling(data,obj)

  minority = data(data(:,obj)==1,:);
  num_min = length(minority);
  majority = data(data(:,obj)==0,:);
  num_maj = length(majority);
  
  if (num_min >= num_maj) 
    rowrank = randperm(size(minority,1)); 
    minority = minority(rowrank, :);
    minority = minority(1:num_maj,:);
  else
    rowrank = randperm(size(majority,1)); 
    majority = majority(rowrank, :);
    majority = majority(1:num_min,:);
  end
  y=[majority;minority];
end