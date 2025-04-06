drop trigger if exists tmuseos on museos; 
create or replace function ftmuseos() returns trigger language plpgsql as $$
declare
vcodpa varchar;
begin
select codpa into vcodpa from museos where codmu=new.codmu2;

if vcodpa = new.codpa then
	raise notice 'aceptada insercion';
	
else
	raise exception 'rexeitada insercion';
	end if;
return new;
end;$$;
create trigger tmuseos before insert on museos for each row execute procedure ftmuseos();