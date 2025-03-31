create or replace procedure ppaises()
language plpgsql
as $$
declare 
vnomp record;
resultado varchar = E'\n';
vnomea record;
c integer;
begin 
for vnomp in select * from paises loop
resultado = resultado ||'pais: '|| vnomp.nomep || E'\n';
for vnomea in select nomea from aeroportos where codigop = vnomp.codigop loop
resultado = resultado ||' '|| vnomea.nomea || E'\n';
c = c + 1;

end loop;  

if c > 0 then
resultado = resultado ||'o numero de aeroportos deste pais e: '|| c || E'\n';
else
resultado = resultado ||'pais sen aeroportos' || E'\n';
end if;
end loop;
raise notice '%', resultado;
end;$$;