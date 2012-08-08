<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:d="http://docbook.org/ns/docbook">

  <xsl:import href="../softlinks/docbook/fo/docbook.xsl" />

  <xsl:param name="shade.verbatim" select="1" />
  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="header.content">
    <xsl:param name="pageclass" select="''" />
    <xsl:param name="sequence" select="''" />
    <xsl:param name="position" select="''" />
    <xsl:param name="gentext-key" select="''" />

    <fo:block>

      <!-- sequence can be odd, even, first, blank -->
      <!-- position can be left, center, right -->
      <xsl:choose>
        <xsl:when test="$sequence = 'blank'">
          <!-- nothing -->
        </xsl:when>

        <xsl:when test="$sequence = 'first' and $position = 'right'">
          <fo:external-graphic content-height="3em">
            <xsl:attribute name="src">
              <xsl:call-template name="fo-external-image">
                <xsl:with-param name="filename"
              select="'images/fdcUpperRightTitleImage.gif'" />
              </xsl:call-template>
            </xsl:attribute>
          </fo:external-graphic>
        </xsl:when>

        <!-- <xsl:when test="$sequence = 'first' and $position = 'left'"> <fo:external-graphic 
          content-height="8em"> <xsl:attribute name="src"> <xsl:call-template name="fo-external-image"> 
          <xsl:with-param name="filename" select="'images/fdcUpperLeftTitleImage.gif'"/> </xsl:call-template> 
          </xsl:attribute> </fo:external-graphic> </xsl:when> -->

        <xsl:when test="$position='left'">
          <!-- Same for odd, even, empty, and blank sequences -->
          <xsl:call-template name="draft.text" />
        </xsl:when>

        <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
          <xsl:if test="$pageclass != 'titlepage'">
            <xsl:choose>
              <xsl:when test="ancestor::d:book and ($double.sided != 0)">
                <fo:retrieve-marker retrieve-class-name="section.head.marker"
                  retrieve-position="first-including-carryover" retrieve-boundary="page-sequence" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="." mode="titleabbrev.markup" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:when>

        <xsl:when test="$position='center'">
          <!-- nothing for empty and blank sequences -->
        </xsl:when>

        <xsl:when test="$position='right'">
          <!-- Same for odd, even, empty, and blank sequences -->
          <xsl:call-template name="draft.text" />
        </xsl:when>

        <xsl:when test="$sequence = 'first'">
          <!-- nothing for first pages -->
        </xsl:when>

        <xsl:when test="$sequence = 'blank'">
          <!-- nothing for blank pages -->
        </xsl:when>
      </xsl:choose>
    </fo:block>
  </xsl:template>


  <xsl:param name="footer.msg" select="''" />

  <xsl:template name="footer.content">
    <xsl:param name="pageclass" select="''" />
    <xsl:param name="sequence" select="''" />
    <xsl:param name="position" select="''" />
    <xsl:param name="gentext-key" select="''" />

    <fo:block>
      <!-- pageclass can be front, body, back -->
      <!-- sequence can be odd, even, first, blank -->
      <!-- position can be left, center, right -->
      <xsl:choose>
        <xsl:when test="$pageclass = 'titlepage'">
          <xsl:message>
            Footer title page called with position =
            <xsl:value-of select="$position" />
            .
          </xsl:message>
          <!-- nop; no footer on title pages -->
        </xsl:when>

        <xsl:when test="$sequence = 'first' and $position = 'left'">
          <fo:external-graphic content-height="1.2em">
            <xsl:attribute name="src">
              <xsl:call-template name="fo-external-image">
                <xsl:with-param name="filename" select="'images/fdcLowerLeftTitleImage.gif'" />
              </xsl:call-template>
            </xsl:attribute>
          </fo:external-graphic>
        </xsl:when>

        <xsl:when
          test="$double.sided != 0 and $sequence = 'even'
                                           and $position = 'left'">
          <fo:page-number />
        </xsl:when>
        <xsl:when
          test="$double.sided != 0 and $sequence = 'even'
                                           and $position = 'right'">
          <xsl:value-of select="$footer.msg" />
        </xsl:when>

        <xsl:when
          test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
                                           and $position='right'">
          <fo:page-number />
        </xsl:when>
        <xsl:when
          test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
                                           and $position='left'">
          <xsl:value-of select="$footer.msg" />
        </xsl:when>

        <xsl:when test="$double.sided = 0 and $position='center'">
          <fo:page-number />
        </xsl:when>
        <xsl:when test="$double.sided = 0 and $position='left'">
          <xsl:value-of select="$footer.msg" />
        </xsl:when>

        <xsl:when test="$sequence='blank'">
          <xsl:choose>
            <xsl:when test="$double.sided != 0 and $position = 'left'">
              <fo:page-number />
            </xsl:when>
            <xsl:when test="$double.sided = 0 and $position = 'center'">
              <fo:page-number />
            </xsl:when>
            <xsl:otherwise>
              <!-- nop -->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>

        <xsl:otherwise>
          <!-- nop -->
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>