/*
 * Copyright 2012 Netflix, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import com.google.common.base.CaseFormat
import com.netflix.asgard.CachedMapBuilder
import com.netflix.asgard.Caches
import com.netflix.asgard.DefaultUserDataProvider
import com.netflix.asgard.Region
import com.netflix.asgard.ServiceInitLoggingBeanPostProcessor
import com.netflix.asgard.ThreadScheduler
import groovy.io.FileType


beans = {
    serviceInitLoggingBeanPostProcessor(ServiceInitLoggingBeanPostProcessor)

    threadScheduler(ThreadScheduler, ref('configService'))

    List<Region> limitedRegions = Region.limitedRegions ?: Region.values()
    cachedMapBuilder(CachedMapBuilder, ref('threadScheduler'), limitedRegions)

    caches(Caches, ref('cachedMapBuilder'), ref('configService'))

    defaultUserDataProvider(DefaultUserDataProvider) { bean ->
        bean.lazyInit = true
    }

    //**** Plugin behavior

    xmlns lang:'http://www.springframework.org/schema/lang'

    File pluginDir = new File("${application.config.asgardHome}/plugins/")

    pluginDir.eachFileMatch(FileType.FILES, ~/.*\.groovy/) { File plugin ->
        String beanName = CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_CAMEL, plugin.name.replace('.groovy', ''))
        lang.groovy(id: beanName, 'script-source': "file:${application.config.asgardHome}/plugins/${plugin.name}",
            'refresh-check-delay': 5000)
    }
}
