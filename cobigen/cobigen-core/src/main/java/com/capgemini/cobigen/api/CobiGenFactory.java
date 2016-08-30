package com.capgemini.cobigen.api;

import java.io.IOException;
import java.net.URI;
import java.nio.file.Path;
import java.util.Objects;

import com.capgemini.cobigen.impl.CobiGenImpl;
import com.capgemini.cobigen.impl.config.ConfigurationHolder;
import com.capgemini.cobigen.impl.config.ContextConfiguration;
import com.capgemini.cobigen.impl.config.nio.ConfigurationChangedListener;
import com.capgemini.cobigen.impl.config.nio.NioFileSystemTemplateLoader;
import com.capgemini.cobigen.impl.exceptions.InvalidConfigurationException;
import com.capgemini.cobigen.impl.util.FileSystemUtil;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapperBuilder;

/**
 * CobiGen's Factory to create new instances of {@link CobiGen}.
 */
public class CobiGenFactory {

    /**
     * Creates a new {@link CobiGen} with a given {@link ContextConfiguration}.
     *
     * @param configFileOrFolder
     *            the root folder containing the context.xml and all templates, configurations etc.
     * @return a new instance of {@link CobiGen}
     * @throws IOException
     *             if the {@link URI} points to a file or folder, which could not be read.
     * @throws InvalidConfigurationException
     *             if the context configuration could not be read properly.
     */
    public static CobiGen create(URI configFileOrFolder) throws InvalidConfigurationException, IOException {
        Objects.requireNonNull(configFileOrFolder,
            "The URI pointing to the configuration could not be null.");

        Path configFolder = FileSystemUtil.createFileSystemDependentPath(configFileOrFolder);
        Configuration freeMarkerConfig = new Configuration(Configuration.VERSION_2_3_23);
        freeMarkerConfig
            .setObjectWrapper(new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_23).build());
        freeMarkerConfig.clearEncodingMap();
        freeMarkerConfig.setDefaultEncoding("UTF-8");
        freeMarkerConfig.setLocalizedLookup(false);
        freeMarkerConfig.setTemplateLoader(new NioFileSystemTemplateLoader(configFolder));

        ConfigurationHolder configurationHolder = new ConfigurationHolder(configFolder);
        if (!FileSystemUtil.isZipFile(configFileOrFolder)) {
            new ConfigurationChangedListener(configFolder, configurationHolder);
        }

        return new CobiGenImpl(freeMarkerConfig, configurationHolder);
    }

}
