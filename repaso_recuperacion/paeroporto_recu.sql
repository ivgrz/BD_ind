create or replace procedure paeroporto(coda varchar)
language plpgsql
as $$
declare 
f1 record;
f2 record;
resultado varchar = E'\n';
c integer = 0;
contadora integer=0;
begin
select count(*) into contadora from aeroportos where codigoa = coda;
if contadora = 0 then 
	resultado = resultado || 'aeroporto inexistente ' || E'\n';

else

select count(*) into contadora from escalas where codigoa = coda;
if contadora = 0 then
resultado = resultado || 'aeroporto sen voos con escalas ' || E'\n';

else
for f1 in select * from escalas where codigoa = coda loop
c = 0;
for f2 in select * from voos where codigov = f1.codigov  loop
resultado = resultado ||'voo: '|| f2.datav ||' '||f2.codigov||' '||f2.horav|| E'\n';


end loop;
end loop;
end if;
end if;
raise notice '%', resultado;
end;$$;