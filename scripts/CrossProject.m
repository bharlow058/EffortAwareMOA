%%%%%%跨项目多目标优化
addpath('datautil')
addpath('MODEP')
addpath('WithinProject')
addpath('CrossProject')
load fisheriris

projects = {'bugzilla','columba','jdt', 'platform' ,'mozilla', 'postgres'};
for i=1:1:length(projects)
    project_train=projects{i};
    train_data = csvread(['..//dataset//',project_train,'.csv'],1);
            
    %模型训练
    wdata_train = doSampling(train_data,10);
    %wdata_train = datapreprocessing(wdata_train);
    save('training_data.mat','wdata_train','-mat');
    [X,FVAL,POPULATION,SCORE,OUTPUT]=MODEP('logistic','nclasses');

    for j = 1:1:length(projects)
        project_test=projects{j};
        if(j~=i)
            %模型测试
            test_data = csvread(['..//dataset//',project_test,'.csv'],1);
            cdata_test = test_data;
            [y,popt_acc] = testLogistic_nclasses(cdata_test,X);

            if(j==1 || (i==1&&j==2))
                wp_popt_acc=popt_acc;
            else
                wp_popt_acc = [wp_popt_acc popt_acc];
            end
        end
    end
    
    csvwrite(['..//dataoutput_cp//',project_train,'.csv'],wp_popt_acc);
end