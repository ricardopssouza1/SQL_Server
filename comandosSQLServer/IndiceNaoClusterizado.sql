CREATE UNIQUE NONCLUSTERED INDEX
[NIX_col5_col2_col3_col4_col6] 
ON [MyAddress] 
(
    [AddressLine1] ASC,
    [AddressLine2] ASC,
    [City] ASC,
    [StateProvinceID] ASC,
    [PostalCode] ASC
)ON [PRIMARY]
GO