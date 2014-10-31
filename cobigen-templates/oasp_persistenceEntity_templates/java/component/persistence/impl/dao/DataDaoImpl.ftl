package ${variables.rootPackage}.${variables.component}.persistence.impl.dao;

import java.util.List;

import javax.persistence.Query;

import ${variables.rootPackage}.general.common.api.constants.NamedQueries;
import ${variables.rootPackage}.general.persistence.base.dao.ApplicationDaoImpl;
import ${variables.rootPackage}.${variables.component}.persistence.api.dao.${variables.entityName}Dao;
import ${variables.rootPackage}.${variables.component}.persistence.api.${pojo.name};

/**
 * This is the implementation of {@link ${variables.entityName}Dao}.
 */
public class ${variables.entityName}DaoImpl extends ApplicationDaoImpl<${pojo.name}> implements ${variables.entityName}Dao {

    /**
      * {@inheritDoc}
      */
     @Override
     public Class<${pojo.name}> getEntityClass() {
       return ${pojo.name}.class;
    }

}
