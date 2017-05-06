

function Map = CreateMap(SmaCirNum,BigCirNum,SmaRectNum,BigRectNum)
map=ones(110,110);
smaCircle=[0 0 0 1 0 0 0;       %7*7
           0 0 1 1 1 0 0;
           0 1 1 1 1 1 0;
           1 1 1 1 1 1 1;
           0 1 1 1 1 1 0;
           0 0 1 1 1 0 0;
           0 0 0 1 0 0 0];
bigCircle=[ 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0   %21*21
            0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0  
            0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0   
            0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0   
            0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0   
            0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0   
            0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0   
            0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0   
            0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0   
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1   
            0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0   
            0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0   
            0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0   
            0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0   
            0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0   
            0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0   
            0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0  
            0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0   
            0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0    
            0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0];    
smaRect=ones(6,3);
bigRect=ones(10,30);
subMap1=zeros(100,100);
subMap2=ones(10,10);
subMap1(75:84,10:19)=subMap2;
subMap1(10:19,75:84)=subMap2;
subMap1(55:61,5:11)=smaCircle;
subMap1(66:72,16:22)=smaCircle;
subMap1(77:83,27:33)=smaCircle;
subMap1(15:35,15:35)=bigCircle;
subMap1(50:55,50:52)=smaRect;
subMap1(65:70,60:62)=smaRect;
subMap1(50:55,70:72)=smaRect;
subMap1(33:42,53:82)=bigRect;

map(5:104,5:104)=subMap1;

if(nargin==0)
    disp('No additional obstacle!');
elseif(nargin==4)
    if(SmaCirNum>0)
        for i=1:SmaCirNum
            rannum = randperm(100);
            map(rannum(5):rannum(5)+6,rannum(10):rannum(10)+6)=smaCircle; 
        end
    end
    if(BigCirNum>0)
        for i=1:BigCirNum
            rannum = randperm(80);
            map(rannum(5):rannum(5)+20,rannum(10):rannum(10)+20)=bigCircle; 
        end
    end
    if(SmaRectNum>0)
        for i=1:SmaRectNum
            rannum = randperm(100);
            map(rannum(5):rannum(5)+5,rannum(10):rannum(10)+2)=smaRect; 
        end
    end
    if(BigRectNum>0)
        for i=1:BigRectNum
            rannum = randperm(70);
            map(rannum(5):rannum(5)+9,rannum(10):rannum(10)+29)=bigRect; 
        end
    end 
end
Map = logical(map);


