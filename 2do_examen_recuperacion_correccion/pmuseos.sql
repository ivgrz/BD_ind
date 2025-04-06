/* 
    Autor:  Ivan Gutierrez
    
    Descripcion: Procedimiento que recibe el nombre de un museo y devuelve la lista de visitantes y la cantidad de ellos.
*/
create or replace procedure pmuseos_1(nomus varchar)
language plpgsql
as $$
declare 
    f1 record;
    f2 record;
    vnomv varchar;
    vcodmu varchar;
    resultado varchar = E'\n';
	c integer = 0;
begin
    
    select codmu into STRICT vcodmu from museos where nommu = nomus; 
        
        for f2 in select codpa,n,datavi from visitan where codmu = vcodmu loop 
            resultado = resultado || 'La fecha de visita ' || f2.datavi;
          select nomv into vnomv from visitantes where codpa=f2.codpa and n=f2.n ;
          resultado = resultado || ' nombre de visitante: ' || vnomv || E'\n';    
          c = c +1;
    end loop; 
  if c = 0 then
  resultado = resultado || 'museo sin visitantes' || E'\n';
  else
  resultado = resultado || 'el numero de visitantes es: '||c||E'\n'; 
  end if;
    raise notice '%', resultado;
    exception
    when no_data_found then
    raise notice 'no existe este museo';
end;$$;