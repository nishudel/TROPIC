classdef MultiphaseNLP < NLP 
    % A class with basic model descriptions and functionalities
    % of the multi-link rigid-body robot platform.
    %
    % - Roy Featherstones. "Rigid Body Dynamics Algorithm". Springer, 2008.
    % http://royfeatherstone.org/spatial/
    %
    % @author Ayonga Hereid @date 2016-09-26
    % @new{1,0, ayonga, 2016-09-26} Migrated from old modelConfig class
    %
    % Copyright (c) 2016, AMBER Lab
    % All right reserved.
    %
    % Redistribution and use in source and binary forms, with or without
    % modification, are permitted only in compliance with the BSD 3-Clause
    % license, see
    % http://www.opensource.org/licenses/bsd-license.php
    
    
    properties (Constant)
        
        
    end
    
    
    properties (GetAccess = public, SetAccess = protected)
        
        % The robot model
        %   type: struct
        %ContactTypes
        
        %ContactFrames
        
        %J_contact
        
        %dJ_contact
        
        %HybridDynamics
        
    end
    
    
    
    
    
    %% Public methods
    methods
        
        
%         function obj = MultiphaseNLP(rbm, argPhases)%, dynamics_type)%varargin )
        function obj = MultiphaseNLP(rbm, argPhases, argNFE, argQuad)%, dynamics_type)%varargin )
                        

            arguments
                rbm (1,1) DynamicalSystem
                argPhases (1,:) cell
                argNFE (1,:) cell
                argQuad (1,:) cell
            end

            % superclass constructor
            obj@NLP()
            

            
            mustBeMember(argPhases{1}, 'Phases')
            
            phases = argPhases(2:end)
            
           
            
            nfe = argNFE(2:end)
            
            
            mustBeMember(argQuad{1}, 'CollocationScheme')

            colScheme = argQuad(2:end)
            
            
            
            prob = {}
            
            

            for i = 1:size(argPhases,2)-1
                i
                phases{i}
                nfe{i}
                colScheme{i}

                prob{i} = NLP(rbm, phases{i}, nfe{i}, colScheme{i}, prob)
                
                % put the NLPs together
                obj.Settings{end+1} = prob{i}.Settings;
                obj.Vars = {obj.Vars{:}, prob{i}.Vars{:}};
                obj.VarsName = {obj.VarsName{:}, prob{i}.VarsName{:}};
                obj.VarsInit = [obj.VarsInit; prob{i}.VarsInit];
                obj.VarsLB = [obj.VarsLB; prob{i}.VarsLB];
                obj.VarsUB = [obj.VarsUB; prob{i}.VarsUB];
                obj.VarsIdx = {obj.VarsIdx{:}, prob{i}.VarsIdx{:}};
                obj.Constr = {obj.Constr{:}, prob{i}.Constr{:}};
                obj.ConstrName = {obj.ConstrName{:}, prob{i}.ConstrName{:}};
                obj.ConstrLB = [obj.ConstrLB; prob{i}.ConstrLB];
                obj.ConstrUB = [obj.ConstrUB; prob{i}.ConstrUB];
                
                if isempty(prob{i}.Cost)
                    prob{i}.Cost = 0;
                end
                
                if i == 1
                    obj.Cost = prob{i}.Cost;
                else
                    obj.Cost = obj.Cost + prob{i}.Cost;
                end
           

                
            end
            

            obj
            
     
            
            % call the superclass constructor
            %obj@NLP(model)
            
           
  
            %{
                THIS ENDS WITH WRAPPING ALL VARIABLES AND 
                ALL CONSTRAINTS OF EACH NLP INTO ONE STRUCTURE
            %}
            'THIS ENDS WITH WRAPPING ALL VARIABLES AND ALL CONSTRAINTS OF EACH NLP INTO ONE STRUCTURE'



        end
        
        
       

    end
    
    
    methods %(Access = private)
        
        [obj] = getPhase(obj)
          
        validatePhase(obj, contacts) 
        
    end
    

    methods
        
        %validateContact(obj, contacts) 
        
%         function validateContact(obj,contacts) 
%              
%             for i = 1:numel(contacts)              
%                                 
%                 switch contacts(i).type
%                     case 'point'
%                         % for point contacts, the contact frame ("position 
%                         % of contact") is given by the position of the end
%                         % effector(s) given by contacts.points                        
%                         mustBeMember('points', fieldnames(contacts))
%                         
%                     case 'line'
%                         error('Need to implement ''line'' contact type.')
% 
%                     case 'plane'
%                         error('Need to implement ''line'' contact type.')
% 
%                     otherwise                        
%                         error('MyComponent:incorrectType',...
%                             'Error. \nContact type must be ''point'', ''line'', or ''plane'', not %s.', contacts(i).type)
%                 end
% 
%             end
%            
%         end
        
    end
    
    
    
    
  
    
end
