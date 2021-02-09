-- BASE GN

-- PATCH pour les test du script

-- On crée un jdd et un CA pour tester les importd
-- Toutes les données auront le même JDD

-- Cette partie doit être faite 'à la main'
-- cad creer les CA et JDD GN et les associer aux protocoles et etude OO dans la table export_oo.cor_dataset

-- on fait en sorte de ne pas pouvoir recreer les infos deux fois


-- INSERT CA
INSERT INTO gn_meta.t_acquisition_frameworks(
        acquisition_framework_name, 
        acquisition_framework_desc,
        acquisition_framework_start_date,
        keywords

)
VALUES (
    CONCAT('test ', :'db_oo_name'),
    CONCAT('importé depuis ', :'db_oo_name'),
    NOW()::date,
    :'db_oo_name'
);

-- INSERT JDD
INSERT INTO gn_meta.t_datasets(
    id_acquisition_framework,
    dataset_name,
    dataset_shortname,
    dataset_desc,
    marine_domain,
    terrestrial_domain
    ) 
    SELECT
        af.id_acquisition_framework,
        CONCAT('test ', :'db_oo_name'),
        CONCAT('test ', :'db_oo_name'),
        CONCAT('importé depuis ', :'db_oo_name'),
        FALSE,
        FALSE
        
        FROM gn_meta.t_acquisition_frameworks af
        WHERE af.keywords = :'db_oo_name'
;

-- ASSIGN id_dataset
UPDATE export_oo.cor_dataset SET (id_dataset) = ( 
    SELECT id_dataset 
    FROM gn_meta.t_datasets
    WHERE  dataset_desc = CONCAT('importé depuis ', :'db_oo_name')
) 
;