%%%%%%利用十折交叉验证，同项目多目标优化，
addpath('datautil')
addpath('MODEP')
addpath('WithinProject')
load fisheriris

projects = {'bugzilla','columba','jdt', 'platform' ,'mozilla', 'postgres'};
for i=1:1:length(projects)
    project=projects{i};
    disp(project);
    train_data = csvread(['..//dataset//',project,'.csv'],1);
    %-----------------------------------------------------------------------
    Recall_Churn=zeros(50,2);
    project_P_A = [1:1001]';
    indices = crossvalind('Kfold',length(train_data),10);
    for m = 1:10
        wp_popt_acc=[m,m];
        disp(m);
        for i = 1:10
              disp(m*10+i);
              test = (indices == i); 
              train = ~test;    %分别取第1、2、...、10份为测试集，其余为训练集
              data_train=train_data(train,:);
              data_test=train_data(test,:);

              data_train = doSampling(data_train,10);%消除类不平衡问题

              %data_train = datapreprocessing(data_train);
              %data_test = datapreprocessing(data_test);

              save('training_data.mat','data_train','-mat');
              save('testing_data.mat','data_test','-mat');
            for j = 1:10
              [X,FVAL,POPULATION,SCORE,OUTPUT]=MODEP('logistic','nclasses');

              [y,popt_acc] = testLogistic_nclasses(X);
              wp_popt_acc = [wp_popt_acc;popt_acc];
            end
        end
        project_P_A = [project_P_A,wp_popt_acc;];
    end
    csvwrite(['..//dataoutput_cv//',project,'.csv'],project_P_A);
end






