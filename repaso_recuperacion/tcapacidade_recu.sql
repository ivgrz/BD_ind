drop trigger if exists tcapacidade on voos; 
create or replace function ftcapacidade() returns trigger language plpgsql as $$
declare 
vnacional integer = 0;

vcount integer = 0;

begin
select capacidade into vnacional from nacional where codigoa = new.codigoao;
select count(*) into vcount from voos where codigoao = new.codigoao; 

if vcount >= vnacional then
    raise exception 'voo rexeitado, superase a capacidade do aeroposto nacional orixen deste voo';
else
    raise notice 'voo aceptado, non se supera a sua capacidade de este aeroporto nacional';
end if;


return new;
end;$$;
create trigger tcapacidade before insert on voos for each row execute procedure ftcapacidade();