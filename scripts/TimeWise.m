%%%%%%time-wise
addpath('datautil')
addpath('MODEP')
addpath('WithinProject')
addpath('CrossProject')
load fisheriris

bugzilla = 96;
columba = 39;
jdt = 75;
mozilla = 79;
platform = 75;
postgres = 162;

projects_value = {bugzilla,columba,jdt, platform ,mozilla,postgres};
projects_name = {'bugzilla','columba','jdt', 'platform' ,'mozilla','postgres'};

for i=1:1:length(projects_value)
    
    for j = 1:1:projects_value{i}
        col_name = [j,j];
        train_data = csvread(['..//dataset_tw//',projects_name{i},'_',int2str(j),'_fit.csv'],1);

        %模型训练
        wdata_train = train_data;
        %wdata_train = datapreprocessing(wdata_train);
        save('training_data.mat','wdata_train','-mat');
        [X,FVAL,POPULATION,SCORE,OUTPUT]=MODEP('logistic','nclasses');

        %模型测试
        test_data = csvread(['..//dataset_tw//',projects_name{i},'_',int2str(j),'_est.csv'],1);
        cdata_test = test_data;
        [y,popt_acc] = testLogistic_nclasses(cdata_test,X);

        if(j==1)
            wp_popt_acc=[col_name;popt_acc];
        else
            popt_acc = [col_name;popt_acc];
            wp_popt_acc = [wp_popt_acc popt_acc];
        end
    end
    csvwrite(['..//dataoutput_tw//',projects_name{i},'.csv'],wp_popt_acc);
end