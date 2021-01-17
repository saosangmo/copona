<?php

class ModelCatalogManufacturer extends Model {
    private $language_id;

    public function __construct($registry) {
        parent::__construct($registry);
        $this->language_id = (int)$registry->config->get('config_language_id');
    }

    public function getManufacturer($manufacturer_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer m 
        LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) 
        WHERE m.manufacturer_id = '" . (int)$manufacturer_id . "' AND m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

        return $query->row;
    }

    public function getManufacturers($data = []) {
        if ($data) {
            $sql = "SELECT * FROM " . DB_PREFIX . "manufacturer m 
            LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id)
            LEFT JOIN " . DB_PREFIX . "url_alias ul on ul.query = concat('manufacturer_id=', m.manufacturer_id) and ul.language_id = '" . $this->language_id . "' 
            WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

            prd($sql);

            $sort_data = [
                'name',
                'sort_order',
            ];

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 20;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            $manufacturer_data = $this->cache->get('manufacturer.' . (int)$this->config->get('config_store_id'));

            if (!$manufacturer_data) {
                $sql = "SELECT * FROM " . DB_PREFIX . "manufacturer m 
                LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id)
                LEFT JOIN " . DB_PREFIX . "url_alias ul on ul.query = concat('manufacturer_id=', m.manufacturer_id) and ul.language_id = '" . $this->language_id . "' 
                WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY name";
                
                $query = $this->db->query($sql);

                $manufacturer_data = $query->rows;

                $this->cache->set('manufacturer.' . (int)$this->config->get('config_store_id'), $manufacturer_data);
            }

            return $manufacturer_data;
        }
    }


    public function getManufacturersByCategory($category_id) {
        $category_ids = [];
        $sql = "select cp.* from " . DB_PREFIX . "category_path cp where cp.path_id = " . (int)$category_id;

        $cache_key = 'manufacturer.getbycategory.' . (int)$category_id . '.' . $this->language_id . '.' . Config::get('config_store_id') . '.' . Config::get('config_customer_group_id');
        $result = $this->cache->get($cache_key);

        if ($result) {
            return $result;
        }

        $query = $this->db->query($sql);

        if ($query->rows) {
            foreach ($query->rows as $row) {
                $category_ids[] = $row['category_id'];
            }
        }
        $category_ids = implode(",", $category_ids);

        $sql = "SELECT m.manufacturer_id, m.name, m.image, COUNT(p.product_id) AS products_total FROM " . DB_PREFIX . "product_to_category AS pc ";
        $sql .= " LEFT JOIN " . DB_PREFIX . "product AS p ON p.product_id = pc.product_id ";
        $sql .= " LEFT JOIN " . DB_PREFIX . "manufacturer AS m ON m.manufacturer_id = p.manufacturer_id ";
        // attributes_filter

        if ($category_ids) {
            $sql .= " WHERE pc.category_id IN (" . $category_ids . ") ";
            $sql .= " AND p.status = 1  GROUP BY m.manufacturer_id ORDER BY m.name ASC";
        } else {
            $sql .= " WHERE p.status = 1  GROUP BY m.manufacturer_id ORDER BY m.name ASC";
        }


        $query = $this->db->query($sql);

        $this->cache->set($cache_key, $query->rows);

        return $query->rows;
    }
}