/*
El Procedimiento pdescubridores que: Muestre nombre y especialidad de todos los descubridores y para cada uno de ellos el nombre y la fecha de sus hallazgos, si un descubridor no teiene halazgos debe imprimirse el mensaje 'descubridor sin hallazgos' tambien debe imprimirse el numero de hallazgos de cada descubridor */



create or replace procedure pdescubridores_1()
language plpgsql
as $$
declare 
f1 record;
f2 record;
vcodd varchar;
resultado varchar= ' ';
c integer = 0;
begin
for f1 in select * from descubridores loop
resultado = resultado||'El descubridor '||f1.nomd||' es '||f1.especialidade||E'\n';
c = 0;
for f2 in select * from achados where codd = f1.codd loop
resultado = resultado ||' Fecha de descubrimiento: '|| f2.datacion ||' Nombre del descubrimiento: '|| f2.noma || E'\n';
c = c + 1;
end loop;  
if c = 0 then
resultado = resultado || 'Descubridor sin hallazgos' || E'\n';
else 
resultado = resultado||'El numero de hallazgos del descubridor es: '||c||E'\n'; 
end if;
end loop;

raise notice '%', resultado;
end;$$;