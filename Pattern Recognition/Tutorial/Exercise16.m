Class1=[0 1 1 1; 0 0 1 0; 0 0 0 1];
Class2= [1 0 0 0; 1 1 0 1; 1 1 1 0];
myMarkerSize=14;

%LDA

mClass2=mean(Class2')';
mClass1=mean(Class1')';

%% class-covariance matrix
cov1=zeros(3,3);
for i=1:4
    cov1=cov1+1/4*[(Class1(:,i)-mClass1)*(Class1(:,i)'-mClass1')];
end
cov2=zeros(3,3);
for i=1:4
    cov2=cov2+1/4*[(Class2(:,i)-mClass2)*(Class2(:,i)'-mClass2')];
end

%% owerall center for all patterns
mAll=0.5*mClass1+0.5*mClass2;

%% Step1: Intraclass scattering matrix and Interclass scattering matrix
covAll=0.5*cov1+0.5*cov2;
Ca=covAll;

Cb=zeros(3,3);
Cb=0.5*[(mAll-mClass1)*(mAll-mClass1)']+0.5*[(mAll-mClass2)*(mAll-mClass2)'];
C=Ca+Cb;

%% Step2: Eigen-values and Eigen-vectors of Ca
[VecA EigA]=eig(Ca);
PhiA=EigA^-0.5*VecA;

%% Step3: Calculate Cb'
Cbnew=PhiA*Cb*PhiA';

%% Step4: Eigen-values and Eigen-vectors of Cb' - set the transformation matrix phib to the eigenvectors Ub'
[VecCbnew EigCbnew] =eig(Cbnew);
PhiB=VecCbnew;

%% Step5: Calculate transformation matrix Phi and transform patterns (class1, class2)
Phi=PhiB*PhiA;
Class1transform=Phi*Class1;
Class2transform=Phi*Class2;

% plot 3D
figure;
for i=1:4
    axis([-4 4 -4 4 -4 4]);
    plot3(Class1transform(1,i),Class1transform(2,i),Class1transform(3,i),'o','MarkerSize',myMarkerSize);
    hold on
    plot3(Class2transform(1,i),Class2transform(2,i),Class2transform(3,i),'x','Color','red','MarkerSize',myMarkerSize);
end
figure;
hold on
for i=1:4
    hold on
    subplot(1,3,1), plot(Class1transform(1,i),Class1transform(2,i),'o');
    hold on
    subplot(1,3,1), plot(Class2transform(1,i),Class2transform(2,i),'x','Color','red');
    hold on
    subplot(1,3,2), plot(Class1transform(1,i),Class1transform(3,i),'o');
    subplot(1,3,2), plot(Class2transform(1,i),Class2transform(3,i),'x','Color','red');
    hold on
    subplot(1,3,3), plot(Class1transform(2,i),Class1transform(3,i),'o');
    subplot(1,3,3), plot(Class2transform(2,i),Class2transform(3,i),'x','Color','red');
end

%% PCA
ClassTransformAll=Class1transform;
ClassTransformAll(:,5:8)=Class2transform;
meanNew=mean(ClassTransformAll')';
covNew=zeros(3,3);
for i=1:8
    covNew=covNew+1/8*[(ClassTransformAll(:,i)-meanNew)*(ClassTransformAll(:,i)-meanNew)'];
end
[VecNew EigNew]=eig(covNew);
new2D=[EigNew(:,2), EigNew(:,3)]'*ClassTransformAll;

% plot
figure;
for i=1:4
    axis([-1 6 -6 10]);
    hold on;
    plot(new2D(1,i),new2D(2,i),'o','MarkerSize',myMarkerSize);
    plot(new2D(1,i+4),new2D(2,i+4),'x','Color','red','MarkerSize',myMarkerSize);
end
