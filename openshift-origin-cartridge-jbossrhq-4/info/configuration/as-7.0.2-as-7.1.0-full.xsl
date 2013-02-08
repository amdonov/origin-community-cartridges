<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:domain="urn:jboss:domain:1.0"
	xmlns:logging="urn:jboss:domain:logging:1.1" xmlns:jca="urn:jboss:domain:jca:1.0"
	xmlns:xalan="http://xml.apache.org/xslt" xmlns:datasources="urn:jboss:domain:datasources:1.0" exclude-result-prefixes="logging domain jca xalan datasources">

	<xsl:output method="xml" indent="yes" xalan:indent-amount="4" />

	<xsl:template match="domain:server">
		<server xmlns="urn:jboss:domain:1.1">
			<extensions>
				<extension module="org.jboss.as.clustering.infinispan" />
				<extension module="org.jboss.as.cmp" />
				<extension module="org.jboss.as.configadmin" />
				<extension module="org.jboss.as.connector" />
				<extension module="org.jboss.as.deployment-scanner" />
				<extension module="org.jboss.as.ee" />
				<extension module="org.jboss.as.ejb3" />
				<extension module="org.jboss.as.jacorb" />
				<extension module="org.jboss.as.jaxr" />
				<extension module="org.jboss.as.jaxrs" />
				<extension module="org.jboss.as.jdr" />
				<extension module="org.jboss.as.jmx" />
				<extension module="org.jboss.as.jpa" />
				<extension module="org.jboss.as.jsr77" />
				<extension module="org.jboss.as.logging" />
				<extension module="org.jboss.as.mail" />
				<extension module="org.jboss.as.messaging" />
				<extension module="org.jboss.as.naming" />
				<extension module="org.jboss.as.osgi" />
				<extension module="org.jboss.as.pojo" />
				<extension module="org.jboss.as.remoting" />
				<extension module="org.jboss.as.sar" />
				<extension module="org.jboss.as.security" />
				<extension module="org.jboss.as.threads" />
				<extension module="org.jboss.as.transactions" />
				<extension module="org.jboss.as.web" />
				<extension module="org.jboss.as.webservices" />
				<extension module="org.jboss.as.weld" />
			</extensions>
			<management>
				<management-interfaces>
					<native-interface>
						<socket-binding native="management-native" />
					</native-interface>
					<http-interface>
						<socket-binding http="management-http" />
					</http-interface>
				</management-interfaces>
			</management>
			<xsl:apply-templates select="domain:profile" />
			<interfaces>
				<interface name="management">
					<loopback-address value="${{OPENSHIFT_INTERNAL_IP}}" />
				</interface>
				<interface name="public">
					<loopback-address value="${{OPENSHIFT_INTERNAL_IP}}" />
				</interface>
				<interface name="unsecure">
					<loopback-address value="${{OPENSHIFT_INTERNAL_IP}}" />
				</interface>
			</interfaces>
			<socket-binding-group name="standard-sockets"
				default-interface="public">
				<socket-binding name="http" port="8080" />
				<socket-binding name="https" port="8443" />
				<socket-binding name="jacorb" interface="unsecure"
					port="3528" />
				<socket-binding name="jacorb-ssl" interface="unsecure"
					port="3529" />
				<socket-binding name="management-native" interface="management"
					port="9999" />
				<socket-binding name="management-http" interface="management"
					port="9990" />
				<socket-binding name="management-https" interface="management"
					port="9443" />
				<socket-binding name="messaging" port="5445" />
				<socket-binding name="messaging-throughput" port="5455" />
				<socket-binding name="osgi-http" port="8090" />
				<socket-binding name="remoting" port="4447" />
				<socket-binding name="txn-recovery-environment" port="4712" />
				<socket-binding name="txn-status-manager" port="4713" />
				<outbound-socket-binding name="mail-smtp">
					<remote-destination host="localhost" port="25" />
				</outbound-socket-binding>
			</socket-binding-group>
		</server>
	</xsl:template>

	<xsl:template match="domain:extensions">
		<extensions>
			<extension module="org.jboss.as.clustering.infinispan" />
			<extension module="org.jboss.as.cmp" />
			<extension module="org.jboss.as.configadmin" />
			<extension module="org.jboss.as.connector" />
			<extension module="org.jboss.as.deployment-scanner" />
			<extension module="org.jboss.as.ee" />
			<extension module="org.jboss.as.ejb3" />
			<extension module="org.jboss.as.jacorb" />
			<extension module="org.jboss.as.jaxr" />
			<extension module="org.jboss.as.jaxrs" />
			<extension module="org.jboss.as.jdr" />
			<extension module="org.jboss.as.jmx" />
			<extension module="org.jboss.as.jpa" />
			<extension module="org.jboss.as.jsr77" />
			<extension module="org.jboss.as.logging" />
			<extension module="org.jboss.as.mail" />
			<extension module="org.jboss.as.messaging" />
			<extension module="org.jboss.as.naming" />
			<extension module="org.jboss.as.osgi" />
			<extension module="org.jboss.as.pojo" />
			<extension module="org.jboss.as.remoting" />
			<extension module="org.jboss.as.sar" />
			<extension module="org.jboss.as.security" />
			<extension module="org.jboss.as.threads" />
			<extension module="org.jboss.as.transactions" />
			<extension module="org.jboss.as.web" />
			<extension module="org.jboss.as.webservices" />
			<extension module="org.jboss.as.weld" />
		</extensions>
	</xsl:template>
	


	<xsl:template match="domain:profile">
		<profile xmlns="urn:jboss:domain:1.1">
			<xsl:apply-templates select="logging:subsystem" />
			<subsystem xmlns="urn:jboss:domain:cmp:1.0" />
			<subsystem xmlns="urn:jboss:domain:configadmin:1.0" />
			<xsl:apply-templates select="datasources:subsystem" />
			<subsystem xmlns="urn:jboss:domain:deployment-scanner:1.1">
				<deployment-scanner path="deployments"
					relative-to="jboss.server.base.dir" scan-interval="5000" />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:ee:1.0" />
			<subsystem xmlns="urn:jboss:domain:ejb3:1.2">
				<session-bean>
					<stateless>
						<bean-instance-pool-ref pool-name="slsb-strict-max-pool" />
					</stateless>
					<stateful default-access-timeout="5000" cache-ref="simple" />
					<singleton default-access-timeout="5000" />
				</session-bean>
				<mdb>
					<resource-adapter-ref resource-adapter-name="hornetq-ra" />
					<bean-instance-pool-ref pool-name="mdb-strict-max-pool" />
				</mdb>
				<pools>
					<bean-instance-pools>
						<strict-max-pool name="slsb-strict-max-pool"
							max-pool-size="20" instance-acquisition-timeout="5"
							instance-acquisition-timeout-unit="MINUTES" />
						<strict-max-pool name="mdb-strict-max-pool"
							max-pool-size="20" instance-acquisition-timeout="5"
							instance-acquisition-timeout-unit="MINUTES" />
					</bean-instance-pools>
				</pools>
				<caches>
					<cache name="simple" aliases="NoPassivationCache" />
					<cache name="passivating" passivation-store-ref="file"
						aliases="SimpleStatefulCache" />
				</caches>
				<passivation-stores>
					<file-passivation-store name="file" />
				</passivation-stores>
				<async thread-pool-name="default" />
				<timer-service thread-pool-name="default">
					<data-store path="timer-service-data" relative-to="jboss.server.data.dir" />
				</timer-service>
				<remote connector-ref="remoting-connector" thread-pool-name="default" />
				<thread-pools>
					<thread-pool name="default">
						<max-threads count="10" />
						<keepalive-time time="100" unit="milliseconds" />
					</thread-pool>
				</thread-pools>
				<iiop enable-by-default="false" use-qualified-name="false" />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:infinispan:1.1"
				default-cache-container="hibernate">
				<cache-container name="hibernate" default-cache="local-query">
					<local-cache name="entity">
						<transaction mode="NON_XA" />
						<eviction strategy="LRU" max-entries="10000" />
						<expiration max-idle="100000" />
					</local-cache>
					<local-cache name="local-query">
						<transaction mode="NONE" />
						<eviction strategy="LRU" max-entries="10000" />
						<expiration max-idle="100000" />
					</local-cache>
					<local-cache name="timestamps">
						<transaction mode="NONE" />
						<eviction strategy="NONE" />
					</local-cache>
				</cache-container>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:jacorb:1.1">
				<orb>
					<initializers transactions="spec" security="on" />
				</orb>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:jaxr:1.0">
				<connection-factory jndi-name="java:jboss/jaxr/ConnectionFactory" />
				<juddi-server publish-url="http://localhost:8080/juddi/publish"
					query-url="http://localhost:8080/juddi/query" />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:jaxrs:1.0" />
			<subsystem xmlns="urn:jboss:domain:jca:1.1">
				<archive-validation xmlns="urn:jboss:domain:jca:1.0"
					enabled="false" />
				<bean-validation xmlns="urn:jboss:domain:jca:1.0"
					enabled="false" />
				<default-workmanager xmlns="urn:jboss:domain:jca:1.0">
					<short-running-threads blocking="true">
						<core-threads count="5" />
						<queue-length count="5" />
						<max-threads count="5" />
						<keepalive-time time="10" unit="seconds" />
					</short-running-threads>
					<long-running-threads blocking="true">
						<core-threads count="5" />
						<queue-length count="5" />
						<max-threads count="5" />
						<keepalive-time time="10" unit="seconds" />
					</long-running-threads>
				</default-workmanager>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:jdr:1.0" />
			<subsystem xmlns="urn:jboss:domain:jmx:1.1">
				<show-model value="true" />
				<remoting-connector />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:jpa:1.0">
				<jpa default-datasource="" />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:jsr77:1.0" />
			<subsystem xmlns="urn:jboss:domain:mail:1.0">
				<mail-session jndi-name="java:jboss/mail/Default">
					<smtp-server outbound-socket-binding-ref="mail-smtp" />
				</mail-session>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:messaging:1.1">
				<hornetq-server>
					<persistence-enabled>true</persistence-enabled>
					<journal-file-size>102400</journal-file-size>
					<journal-min-files>2</journal-min-files>

					<connectors>
						<netty-connector name="netty" socket-binding="messaging" />
						<netty-connector name="netty-throughput"
							socket-binding="messaging-throughput">
							<param key="batch-delay" value="50" />
						</netty-connector>
						<in-vm-connector name="in-vm" server-id="0" />
					</connectors>

					<acceptors>
						<netty-acceptor name="netty" socket-binding="messaging" />
						<netty-acceptor name="netty-throughput"
							socket-binding="messaging-throughput">
							<param key="batch-delay" value="50" />
							<param key="direct-deliver" value="false" />
						</netty-acceptor>
						<in-vm-acceptor name="in-vm" server-id="0" />
					</acceptors>

					<security-settings>
						<security-setting match="#">
							<permission type="send" roles="guest" />
							<permission type="consume" roles="guest" />
							<permission type="createNonDurableQueue" roles="guest" />
							<permission type="deleteNonDurableQueue" roles="guest" />
						</security-setting>
					</security-settings>

					<address-settings>
						<address-setting match="#">
							<dead-letter-address>jms.queue.DLQ</dead-letter-address>
							<expiry-address>jms.queue.ExpiryQueue</expiry-address>
							<redelivery-delay>0</redelivery-delay>
							<max-size-bytes>10485760</max-size-bytes>
							<address-full-policy>BLOCK</address-full-policy>
							<message-counter-history-day-limit>10
							</message-counter-history-day-limit>
						</address-setting>
					</address-settings>

					<jms-connection-factories>
						<connection-factory name="InVmConnectionFactory">
							<connectors>
								<connector-ref connector-name="in-vm" />
							</connectors>
							<entries>
								<entry name="java:/ConnectionFactory" />
							</entries>
						</connection-factory>
						<connection-factory name="RemoteConnectionFactory">
							<connectors>
								<connector-ref connector-name="netty" />
							</connectors>
							<entries>
								<entry name="RemoteConnectionFactory" />
								<entry name="java:jboss/exported/jms/RemoteConnectionFactory" />
							</entries>
						</connection-factory>
						<pooled-connection-factory name="hornetq-ra">
							<transaction mode="xa" />
							<connectors>
								<connector-ref connector-name="in-vm" />
							</connectors>
							<entries>
								<entry name="java:/JmsXA" />
							</entries>
						</pooled-connection-factory>
					</jms-connection-factories>

					<jms-destinations>
						<jms-queue name="testQueue">
							<entry name="queue/test" />
							<entry name="java:jboss/exported/jms/queue/test" />
						</jms-queue>
						<jms-topic name="testTopic">
							<entry name="topic/test" />
							<entry name="java:jboss/exported/jms/topic/test" />
						</jms-topic>
					</jms-destinations>
				</hornetq-server>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:naming:1.1" />
			<subsystem xmlns="urn:jboss:domain:osgi:1.2" activation="lazy">
				<properties>
					<!-- Specifies the beginning start level of the framework -->
					<property name="org.osgi.framework.startlevel.beginning">1</property>
				</properties>
				<capabilities>
					<!-- modules registered with the OSGi layer on startup -->
					<capability name="javax.servlet.api:v25" />
					<capability name="javax.transaction.api" />
					<!-- bundles started in startlevel 1 -->
					<capability name="org.apache.felix.log" startlevel="1" />
					<capability name="org.jboss.osgi.logging" startlevel="1" />
					<capability name="org.apache.felix.configadmin"
						startlevel="1" />
					<capability name="org.jboss.as.osgi.configadmin"
						startlevel="1" />
				</capabilities>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:pojo:1.0" />
			<subsystem xmlns="urn:jboss:domain:remoting:1.1">
				<connector name="remoting-connector" socket-binding="remoting" />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:resource-adapters:1.0" />
			<subsystem xmlns="urn:jboss:domain:sar:1.0" />
			<subsystem xmlns="urn:jboss:domain:security:1.1">
				<security-domains>
					<security-domain name="other" cache-type="default">
						<authentication>
							<login-module code="UsersRoles" flag="required" />
						</authentication>
					</security-domain>
					<security-domain name="jboss-web-policy"
						cache-type="default">
						<authorization>
							<policy-module code="Delegating" flag="required" />
						</authorization>
					</security-domain>
					<security-domain name="jboss-ejb-policy"
						cache-type="default">
						<authorization>
							<policy-module code="Delegating" flag="required" />
						</authorization>
					</security-domain>
				</security-domains>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:threads:1.1" />
			<subsystem xmlns="urn:jboss:domain:transactions:1.1">
				<core-environment>
					<process-id>
						<uuid />
					</process-id>
				</core-environment>
				<recovery-environment socket-binding="txn-recovery-environment"
					status-socket-binding="txn-status-manager" />
				<coordinator-environment default-timeout="300" />
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:web:1.1"
				default-virtual-server="default-host" native="false">
				<connector name="http" protocol="HTTP/1.1" scheme="http"
					socket-binding="http" />
				<virtual-server name="default-host"
					enable-welcome-root="false">
					<alias name="localhost" />
				</virtual-server>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:webservices:1.1">
				<modify-wsdl-address>true</modify-wsdl-address>
				<wsdl-host>${env.OPENSHIFT_INTERNAL_IP}</wsdl-host>
				<endpoint-config name="Standard-Endpoint-Config" />
				<endpoint-config name="Recording-Endpoint-Config">
					<pre-handler-chain name="recording-handlers"
						protocol-bindings="##SOAP11_HTTP ##SOAP11_HTTP_MTOM ##SOAP12_HTTP ##SOAP12_HTTP_MTOM">
						<handler name="RecordingHandler"
							class="org.jboss.ws.common.invocation.RecordingServerHandler" />
					</pre-handler-chain>
				</endpoint-config>
			</subsystem>
			<subsystem xmlns="urn:jboss:domain:weld:1.0" />
		</profile>
	</xsl:template>

	<xsl:template match="logging:subsystem">
		<subsystem xmlns="urn:jboss:domain:logging:1.1">
			<xsl:copy-of select="logging:*">
			</xsl:copy-of>
		</subsystem>
	</xsl:template>

	<xsl:template match="jca:subsystem">
		<subsystem xmlns="urn:jboss:domain:jca:1.1">
			<xsl:copy-of select="jca:*">
			</xsl:copy-of>
		</subsystem>
	</xsl:template>
	
	<xsl:template match="datasources:subsystem">
		<subsystem xmlns="urn:jboss:domain:datasources:1.0">
			<xsl:copy-of select="datasources:*">
			</xsl:copy-of>
		</subsystem>
	</xsl:template>

	<xsl:template match="/">
		<xsl:apply-templates select="domain:server" />
	</xsl:template>

</xsl:stylesheet>