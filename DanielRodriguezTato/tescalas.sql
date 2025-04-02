drop trigger if exists tescalas on escalas; 
create or replace function ftescalas() returns trigger language plpgsql as $$
declare 

contador integer;

begin

    select count(*) into contador from escalas where codigov = new.codigov;
    
    
if contador >= 3 then
    raise exception 'escala rexeitada, este voo xa fai escala en tre aerupuertos';
else
    raise notice 'escala aceptada';
end if;
return new;
end; $$;

create trigger tescalas before insert on escalas for each row execute procedure ftescalas();

/*
tescalas count if
crea un trigger que impida que un mesmo voo poda facer escala en mas de 3 aropostos
insert into escalas values ('v1','a3'); escala aceptada
insert into escalas values ('v1','a2'); escala rexeitada, este voo xa fai escala en tre aerupuertos
*/
