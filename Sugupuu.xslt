<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
		<strong>1. Trüki välja sugupuu kõikide inimeste nimed ja sünniaastad</strong>
		<ul>
			<xsl:for-each select="//inimene">
				<xsl:sort select="@synd"/>
				<li>
					<xsl:value-of select="concat(nimi, ' (', @synd, ')')"/>
				</li>
			</xsl:for-each>
		</ul>
		<strong>2. Väljasta nimed, kellel vähemalt 2 last</strong>
		<xsl:for-each select="//inimene[lapsed]">
			<li>
				<xsl:if test="count(lapsed/inimene) &gt;=2">
					<xsl:value-of select="concat(nimi, ' (', @synd, ') / ')"/>
					<xsl:value-of select="count(lapsed/inimene)"/> - last
				</xsl:if>
			</li>
		</xsl:for-each>

		<strong>3. Väljasta saadud andmed tabelina</strong>
		<br></br>
		<table style="border-collapse: collapse;margin: 25px 0;font-size: 0.9em;font-family: sans-serif;min-width: 400px;box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);" >
			<thead style="background-color: #009879;color: #ffffff;text-align: left;">
				<tr>
					<th>Nimi</th>
					<th>Vanem</th>
					<th>Sunniaasta</th>
					<th>Vanus</th>
					<th>4</th>
				</tr>
			</thead>

			<tbody>
				<xsl:for-each select="//inimene">
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="string-length(nimi) &lt;= 10">
								<td bgcolor="red"></td>
							</xsl:when>
							<xsl:when test="string-length(nimi) &lt;= 13">
								<td bgcolor="green"></td>
							</xsl:when>
							<xsl:otherwise>
								<td>
									<xsl:value-of select="nimi"/>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:value-of select="../../nimi"/>
					</td>
					<td>
						<xsl:value-of select="@synd"/>
					</td>
					<td>
						<xsl:value-of select="2023-@synd"/>
					</td>
				</tr>	
				</xsl:for-each>
			</tbody>
		</table>
		<br></br>
		<strong>4. Väljasta iga inimese juures mitmendal oma vanema sünniaastal ta sündis</strong>

		<table style="border-collapse: collapse;margin: 25px 0;font-size: 0.9em;font-family: sans-serif;min-width: 400px;box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);" >
			<thead style="background-color: #009879;color: #ffffff;text-align: left;">
				<tr>
					<th>Nimi</th>
					<th>Lapsevanema vanus</th>
				</tr>
			</thead>

			<tbody>
				<xsl:for-each select="//inimene">
					<xsl:sort select="@synd"/>
					<tr>
						<td>
							<xsl:value-of select="nimi"/>
						</td>
						<td>
							<xsl:if test="../..">
								<xsl:value-of select="../../@synd - @synd"/>
							</xsl:if>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>

		<strong>5. Värvida tabelis kõik nimed pikkusega väiksem kui 10 tähte rohelise taustavärviga</strong>
		
		
    </xsl:template>
</xsl:stylesheet>
