CREATE OR REPLACE FUNCTION public.uplink(IN iface_name text)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100
    
AS $BODY$
DECLARE
    result numeric;
BEGIN
    IF iface_name LIKE '%runk%' THEN
        result := 2;
    ELSIF iface_name LIKE '%tengiga%' THEN
        result := 10;
    ELSIF iface_name LIKE '%XGigabitEthernet%' THEN
        result := 10;
    ELSIF iface_name LIKE '%xgei%' THEN
        result := 10;
    ELSIF iface_name LIKE '%gei%' THEN
        result := 1;
    ELSIF iface_name LIKE '%GigabitEthernet%' THEN
        result := 1;
    ELSIF iface_name LIKE '%Gi%' THEN
        result := 1;
    ELSIF iface_name LIKE '%gigaethernet%' THEN
        result := 1;
    ELSIF iface_name LIKE '1/%' THEN
        result := 1;
    ELSIF iface_name LIKE '%port-channel%' THEN
        result := 2;
    ELSIF iface_name LIKE '%smartgroup%' THEN
        result := 2;
    ELSIF iface_name LIKE 'Po%' THEN
        result := 2;
    ELSE
        result := 0;
    END IF;

	
    RETURN result;
END;
$BODY$;
