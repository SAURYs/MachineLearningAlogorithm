%Connected component Analysis fuction
%input: binary image(matrix),output: labeled compoents image
function [labeled_image,equivalence] = cca(orginal_image)
orginal_image=double(orginal_image);
[row_num,col_num] = size(orginal_image);
%index of each row nonzero entries
row_index_none_zero = cell(row_num,1);
for i = 1:row_num
    row_index_none_zero{i} =find(orginal_image(i,:)>0);
end
%�жϵ�һ������Ԫ�س�������һ��
%�ȴ����һ��
a =find(orginal_image.'>0);
a= ceil(a(1)/col_num);
global n;
global num_equivalence;
num_equivalence=1;
n=1;
%if orginal_image(a,row_index_none_zero{a}(1))==1
for i=1:(size(row_index_none_zero{a},2)-1)
    if row_index_none_zero{a}(i+1)-row_index_none_zero{a}(i)==1
        %orginal_image(a,row_index_none_zero{a}(i))=n;
        orginal_image(a,row_index_none_zero{a}(i+1))=orginal_image(a,row_index_none_zero{a}(i));
    else
        n=n+1;
        orginal_image(a,row_index_none_zero{a}(i+1))=n;
        %disp(n)
    end
end



for i =(a+1):row_num
    if any(row_index_none_zero{i})
        %orginal_image(i,row_index_none_zero{i}(1))=orginal_image(i-1,row_index_none_zero{i}(end))+1;
        %���ж�����һ�����޹�����
        index_intersect = intersect(row_index_none_zero{i},row_index_none_zero{i-1});
        if index_intersect
            for i_ = 1:size(index_intersect,2)
                orginal_image(i,index_intersect(i_))=orginal_image(i-1,index_intersect(i_));
            end
        end
        %�����׸���0Ԫ��
        if orginal_image(i,row_index_none_zero{i}(1))~=orginal_image(i-1,row_index_none_zero{i}(1))
            n=n+1;
            orginal_image(i,row_index_none_zero{i}(1))=n;
        end
        for ii=1:(size(row_index_none_zero{i},2)-1)
            if row_index_none_zero{i}(ii+1)-row_index_none_zero{i}(ii)==1
                %�������жϸ�Ԫ���Ƿ��Ѿ���ֵ
                if orginal_image(i,row_index_none_zero{i}(ii+1))~=1
                    %�������жϸ�Ԫ���Ƿ�����Լ��������ھʹ���equivalence
                    if (orginal_image(i,row_index_none_zero{i}(ii+1))~=...
                            orginal_image(i,row_index_none_zero{i}(ii)))
                        %�����Ӧ��ϵ��
                        equivalence{num_equivalence}=[orginal_image(i,row_index_none_zero{i}(ii+1)),...
                            orginal_image(i,row_index_none_zero{i}(ii))];
                        %index��1
                        num_equivalence=num_equivalence+1;
                    end
                    %��û�и�ֵ
                else
                    orginal_image(i,row_index_none_zero{i}(ii+1))=orginal_image(i,row_index_none_zero{i}(ii));
                end
                
            elseif row_index_none_zero{i}(ii+1)-row_index_none_zero{i}(ii)>1
                %�ж��Ƿ��Ѿ���ֵ
                if orginal_image(i,row_index_none_zero{i}(ii+1))~=1
              %��û�и�ֵ
                elseif orginal_image(i,row_index_none_zero{i}(ii+1))==1
                    if orginal_image(i-1,row_index_none_zero{i}(ii+1))~=1
                        n=n+1;
                        orginal_image(i,row_index_none_zero{i}(ii+1))=n;
                    end
                end
                
            end
        end
    end
end

%ȥ���ظ�ֵ
labeled_image=orginal_image;
size_equivalence_matrix=size(equivalence,2);
equivalence=equivalence';
equivalence_matrix = cell2mat(equivalence);
equivalence_matrix =unique(equivalence_matrix,'rows');
size_equivalence_matrix=size(equivalence_matrix,1);
%����run
equivalence=mat2cell(equivalence_matrix,ones(1,size_equivalence_matrix));
equivalence=equivalence';
for i =1:size(equivalence,2)-1
    for ii=1:size(equivalence,2)
        if i~=ii
            if intersect(equivalence{i},equivalence{ii})
                equivalence{i}=union(equivalence{i},equivalence{ii});
            end
        end
    end
end
 for i =1:size(equivalence,2)
    equivalence{i}=mat2str(equivalence{i});
 end
%�ϲ�
equivalence=unique(equivalence);
for i =1:size(equivalence,2)
    equivalence{i}=str2num(equivalence{i});
end

for i =1:size(equivalence,2)
    temp = size(equivalence{i},2);
    temp_=[];
    for i_ =1:temp
    temp_ =union(find(labeled_image==equivalence{i}(i_)),temp_);
    end
  labeled_image(temp_)=equivalence{i}(1);
end

  %���±�� 
ui_temp=unique(labeled_image);
ui = ui_temp(ui_temp>0);
for j_ = 1:size(ui,1)
    labeled_image(labeled_image==ui(j_))=j_;
end
%Ϳɫ
num_color = max(max(labeled_image));
m_cmap =zeros (num_color,3);
m_cmap(:,1)=[1;rand(num_color-1,1)];
m_cmap(:,2)=[1;rand(num_color-1,1)];
m_cmap(:,3)=[1;rand(num_color-1,1)];
figure
subplot(1,2,1)
imshow(orginal_image);
subplot(1,2,2)
imshow(labeled_image,colormap(m_cmap));
end




        

