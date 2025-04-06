drop trigger if exists tclas on non_estructuras; 
create or replace function ftclas() returns trigger language plpgsql as $$
declare
cuenta integer = 0;
begin
select count(*) into cuenta from estructuras where coda=new.coda;
if cuenta = 1 then
	raise exception 'rexeitada insercion';
else
	raise notice 'aceptada insercion';
	end if;
return new;
end;$$;
create trigger tclas before insert on non_estructuras for each row execute procedure ftclas();