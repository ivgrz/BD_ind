drop trigger if exists tescalas on escalas; 
create or replace function ftescalas() returns trigger language plpgsql as $$
declare 
vvuelo integer;

begin
select count(*) into vvuelo from escalas where codigov = new.codigov;


if vvuelo >= 3 then
    raise exception 'no se acepta la insercion, el vuelo ya tiene tres escalas';

else 
    raise notice 'insercion aceptada en escalas';
end if;


return new;
end;$$;
create trigger tescalas before insert on escalas for each row execute procedure ftescalas();