<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@* | node()">
		<strong>1. Выведите имя бабушки, за которым следует точка с запятой, и ее детей.</strong>
		<ul>
			<xsl:for-each select="/inimene">
				<xsl:sort select="inimene/@synd"/>
				<li>
					<xsl:value-of select="concat(nimi, ' ; ', lapsed/inimene[1]/nimi, ', ', lapsed/inimene[2]/nimi)"/>
				</li>
			</xsl:for-each>
		</ul>

		<strong>2. Вывод всех данных в таблице.</strong>

		<br></br>
		<table style="border-collapse: collapse;margin: 25px 0;font-size: 0.9em;font-family: sans-serif;min-width: 400px;box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);" >
			<thead style="background-color: #009879;color: #ffffff;text-align: left;">
				<tr>
					<th>Nimi</th>
					<th>Sunniaasta</th>
					<th>Vanus</th>
				</tr>
			</thead>

			<tbody>
				<xsl:for-each select="//inimene">
					<tr>
						<td>
							<xsl:value-of select="nimi"/>
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


		<strong>3.Рассчитайте, сколько человек проживает в каждом жилом помещении </strong>
		<br></br>
		<xsl:for-each select="//inimene[not(@residence=preceding::inimene/@residence)]">
			<xsl:variable name="residence" select="@residence"/>
			<xsl:variable name="count" select="count(//inimene[@residence = $residence])"/>
			<xsl:text>&#10;</xsl:text>
			<xsl:text>&#10;Residence: </xsl:text>
			<xsl:value-of select="$residence"/>
			<ul>
				<li>
					<xsl:text> - Количество людей:  </xsl:text>
					<xsl:value-of select="$count"/>
				</li>
			</ul>
		</xsl:for-each>

		<strong>4. Узнайте, сколько детей у каждого человека.</strong>

		<table>
			<thead>
				<tr>
					<th>Nimi</th>
					<th>Kokku</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="//inimene">
					<tr>
						<td>
							<xsl:value-of select="nimi"/>
						</td>
						<td>
							<xsl:value-of select="count(lapsed/inimene)"/>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
    </xsl:template>
</xsl:stylesheet>