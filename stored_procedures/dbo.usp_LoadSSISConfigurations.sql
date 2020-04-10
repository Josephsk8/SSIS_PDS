USE [SSIS_PDS]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 3/4/2020 6:56:09 PM ******/
DROP PROCEDURE [dbo].[usp_LoadSSISConfigurations]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 3/4/2020 6:56:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_LoadSSISConfigurations]
AS
    BEGIN

/*****************************************************************************************************************
NAME:    dbo.usp_LoadSSISConfigurations
PURPOSE: Load the SSIS Configurations table

MODIFICATION LOG:
Ver      Date        Author           Description
-------  ----------  ---------------  ------------------------------------------------------------------------
1.0      11/03/2019  JMueras          1. Created this process for LDS BC IT243
1.1      02/04/2020  JMueras          1. Added conn_DFNB3 connection configuration
1.2      02/04/2020  JMueras          1. Added LoadDFNB3_JM configuration
1.3      02/08/2020  JMueras          1. Added LoadEXM_JM configuration 
1.4      02/08/2020  JMueras          1. Added LoadNAICSCodeHierDim_JM configuration 


RUNTIME: 
approx 5 sec

NOTES:  
Load configured variable values for these levels...
1) System = CommonConfigurations
2) Solution
3) Package


Loads configuration managers for common configuration managers used in template package

Connect strings are loaded with passwords to allow for automation of SSIS ETL based packages
         
Example usage...

EXEC dbo.usp_LoadSSISConfigurations;

SELECT c.*
	FROM dbo.[SSIS Configurations] as c;

******************************************************************************************************************/

        TRUNCATE TABLE dbo.[SSIS Configurations];

        -- 1) Common Configurations

        DELETE FROM dbo.[SSIS Configurations]
        WHERE ConfigurationFilter = 'CommonConfigurations';

        -- 1.1) conn_EXM

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('CommonConfigurations', 
         'Data Source=localhost;Initial Catalog=EXM;Provider=SQLNCLI11;Integrated Security=SSPI;', 
         '\Package.Variables[User::conn_EXM].Properties[Value]', 
         'String'
        );  

		-- 1.2) conn_DFNB3

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('CommonConfigurations', 
         'Data Source=localhost;Initial Catalog=DFNB3;Provider=SQLNCLI11;Integrated Security=SSPI;', 
         '\Package.Variables[User::conn_DFNB3].Properties[Value]', 
         'String'
        );  



        -- 2) Solution Level Configurations
        -- 2.1) LDSBC_IT243_xx  

        DELETE FROM dbo.[SSIS Configurations]
        WHERE ConfigurationFilter = 'LDSBC_IT243_JM';

        -- 2.1.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('LDSBC_IT243_JM', 
         'C:\Users\Coolest Joseph\Documents\Joseph\Joseph\Data Warehousing\Project\repos\DFNB_src\txt_files\', 
         '\Package.Variables[User::v_data_share_root].Properties[Value]', 
         'String'
        );

        -- 3) Package level configurations
        -- 3.1) SSIS_PDS_Template_JM

        DELETE FROM dbo.[SSIS Configurations]
        WHERE ConfigurationFilter = 'SSIS_PDS_Template_JM';

        -- 3.1.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('SSIS_PDS_Template_JM', 
         'C:\Users\Coolest Joseph\Documents\Joseph\Joseph\Data Warehousing\Project\repos\DFNB_src\txt_files\', 
         '\Package.Variables[User::v_data_share_root].Properties[Value]', 
         'String'
        );

		   -- 3.2) LoadDFNB3_JM

        DELETE FROM dbo.[SSIS Configurations]
        WHERE ConfigurationFilter = 'LoadDFNB3_JM';

        -- 3.2.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('LoadDFNB3_JM', 
         'C:\Users\Coolest Joseph\Documents\Joseph\Joseph\Data Warehousing\Project\repos\DFNB_src\txt_files\', 
         '\Package.Variables[User::v_data_share_root].Properties[Value]', 
         'String'
        );
			   -- 3.3) LoadEXM_JM

        DELETE FROM dbo.[SSIS Configurations]
        WHERE ConfigurationFilter = 'LoadEXM_JM';

        -- 3.3.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('LoadEXM_JM', 
         'C:\Users\Coolest Joseph\Documents\Joseph\Joseph\Data Warehousing\Project\repos\EXM\txt_files\', 
         '\Package.Variables[User::v_data_share_root].Properties[Value]', 
         'String'
        );
	
	
	-- 3.4) LoadNAICSCodeHierDim_JM

        DELETE FROM dbo.[SSIS Configurations]
        WHERE ConfigurationFilter = 'LoadNAICSCodeHierDim_JM';

        -- 3.4.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations]
        (ConfigurationFilter, 
         ConfiguredValue, 
         PackagePath, 
         ConfiguredValueType
        )
        VALUES
        ('LoadNAICSCodeHierDim_JM', 
         'C:\Users\Coolest Joseph\Documents\Joseph\Joseph\Data Warehousing\Project\repos\DFNB_dw\xls_files\', 
         '\Package.Variables[User::v_data_share_root].Properties[Value]', 
         'String'
        );
	
	  END;
GO


