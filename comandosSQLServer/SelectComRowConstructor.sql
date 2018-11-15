/* exemplos de Select */

/* Row Constructor */

select *
  from (values('teste 1'),('teste 2'),('teste 3')) as Rc(a)


/* Row Constructor - varias linhas */

select *
  from (values('teste 1','campo 1'),('teste 2','campo 1'),('teste 3','campo 1')) as Rc(a,b)


