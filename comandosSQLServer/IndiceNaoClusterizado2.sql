ALTER TABLE [MyAddressType] 
ADD  CONSTRAINT [DEFF_MyAddressType_ModifiedDate]  
DEFAULT (getdate()) FOR [ModifiedDate]
GO