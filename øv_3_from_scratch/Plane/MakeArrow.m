function MakeArrow( offset, v, Scale, FS, SW, name, varargin )

    propertyNames = {'edgeColor'};
    propertyValues = {'none'};    
    %% evaluate property specifications
    for argno = 1:2:nargin-6
        switch varargin{argno}
            case 'color'
                propertyNames = {propertyNames{:},'facecolor'};
                propertyValues = {propertyValues{:},varargin{argno+1}};
            otherwise
                propertyNames = {propertyNames{:},varargin{argno}};
                propertyValues = {propertyValues{:},varargin{argno+1}};
        end

    end 

    h = mArrow3(offset,offset + Scale*v , 'stemWidth', 2*SW); 
    %set(h, 'facecolor', [0,0.5,0],'facealpha', 0.5);

    text(offset(1)+Scale*v(1),offset(2)+Scale*v(2),offset(3)+Scale*v(3),name,'verticalalignment','bottom','horizontalalignment','right','fontsize',FS,'interpreter','latex','color',[0,0.5,0])

    for propno = 1:numel(propertyNames)
        try
            set(h,propertyNames{propno},propertyValues{propno});
        catch
            disp(lasterr)
        end
    end

    
end


