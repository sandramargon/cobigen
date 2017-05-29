<#-- -------------------- -->
<#-- OASP SPECIFIC MACROS -->
<#-- -------------------- -->

<#--
	Generates all field declaration whereas Entity references will be converted to appropriate id references
-->
<#macro generateFieldDeclarations_withRespectTo_entityObjectToIdReferenceConversion boxPrimitives=false>
<#list pojo.fields as field>
<#if field.type?contains("Entity")> <#-- add ID getter & setter for Entity references only for ID references -->
   	private ${field.type?replace("[^<>,]+Entity","Long","r")} ${EmbeddablesFunctions.resolveIdVariableName(field)};
<#else>
	private <#if boxPrimitives>${JavaUtil.boxJavaPrimitives(field.type)}<#else>${field.type}</#if> ${field.name};
</#if>
</#list>
</#macro>

<#--
	Generates all setter and getter for the fields whereas for Entity fields it will generate setter and getter for id references
-->
<#macro generateSetterAndGetter_withRespectTo_entityObjectToIdReferenceConversion implementsInterface=true>
<#list pojo.fields as field>
<#if field.type?contains("Entity")> <#-- add ID getter & setter for Entity references only for ID references -->

	<#assign idVar = EmbeddablesFunctions.resolveIdVariableName(field)>
	<#if implementsInterface>
	@Override</#if>
	public ${EmbeddablesFunctions.getSimpleEntityTypeAsLongReference(field)} ${EmbeddablesFunctions.resolveIdGetter(field,false,variables.component)} {
		return ${idVar};
	}

	<#if implementsInterface>
	@Override</#if>
	public void ${EmbeddablesFunctions.resolveIdSetter(field,false,variables.component)}(${EmbeddablesFunctions.getSimpleEntityTypeAsLongReference(field)} ${idVar}) {
		this.${idVar} = ${idVar};
	}
<#else>
   	<#if implementsInterface>
	@Override</#if>
	public ${field.type} get${field.name?cap_first}() {
		return ${field.name};
	}

	<#if implementsInterface>
	@Override</#if>
	public void set${field.name?cap_first}(${field.type} ${field.name}) {
		this.${field.name} = ${field.name};
	}
</#if>
</#list>
</#macro>