CREATE OR REPLACE FUNCTION public.max_traffic(IN traf_in numeric,IN traf_out numeric)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100
    
AS $BODY$
DECLARE
    result numeric;
BEGIN
    IF traf_in > traf_out THEN
        result := traf_in;
    ELSE
        result := traf_out;
    END IF;
    RETURN result;
	
END;
$BODY$;
