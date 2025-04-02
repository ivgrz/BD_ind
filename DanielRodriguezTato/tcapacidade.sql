drop trigger if exists tescalas on voos; 
create or replace function ftescalas() returns trigger language plpgsql as $$
declare 

ccapacidade integer;
cvoos integer;

begin

    select capacidade into ccapacidade from nacional where codigoa = new.codigoao;
    
    select count(*) into cvoos from voos where codigoao = new.codigoao;
    
    
if ccapacidade <= cvoos then
    raise exception 'vii rexeitado, superase a capacidade do aeroposto nacional orixen deste voo';
else
    raise notice 'voo aceptado, non se supera a sua capacidade de este aeroporto nacional';
end if;
return new;
end; $$;

create trigger tescalas before insert on voos for each row execute procedure ftescalas();

/*
trigger que impida que o numero de voos con orixen nun aeropporto nacional supere a capacidade de dito aeroporto.

tcapacidade
insert into voos values ('v13','12/9/2017',16,100,'tap','a11','a3','boeing777'); rexeita
insert into voos values ('v14','12/9/2017',16,25,'tap','a12','a3','boeing777'); aceptado
*/
