Return-Path: <s104259@yahoo.it>
Date: Tue, 4 Mar 2008 11:26:48 +0100 (CET)
From: Angelo <s104259@yahoo.it>
Subject: I2S driver
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1816320898-1204626408=:28874"
Message-ID: <766668.28874.qm@web23115.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1816320898-1204626408=:28874
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Angelo wrote:
> Timur wrote:
>>I wrote an ASoC driver for the MPC8610, which also has 
>>an I2S interface.  You can find it in sound/soc/fsl.
> 
> in my kernel version (2.6.22) there isn't any folder named
> fsl in sound/soc/

> Timur wrote:
> It's in 2.6.25.


The main problem is that in the feature of MPC8610 you can find:
  Two synchronous serial interface (SSI) controllers for I2S or AC97   
  audio     inputs/outputs

while in MPC5200b's feature there's only:
  I2S (up to three)
However the main difference features:
MPC5200B: http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5200B&nodeId=0162468rH3bTdG0898
MPC8610:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC8610

What do you think on this difference?




       
---------------------------------

---------------------------------
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail
--0-1816320898-1204626408=:28874
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<pre>Angelo wrote:<br>&gt;<i> Timur wrote:<br></i>&gt;&gt;<i>I wrote an ASoC driver for the MPC8610, which also has <br></i>&gt;&gt;<i>an I2S interface.  You can find it in sound/soc/fsl.<br></i>&gt;<i> <br></i>&gt;<i> in my kernel version (2.6.22) there isn't any folder named<br></i>&gt;<i> fsl in sound/soc/<br></i><br>&gt;<i> Timur wrote:</i><br>&gt; It's in 2.6.25.<br><br></pre><div style="text-align: left;">The main problem is that in the feature of MPC8610 you can find:<br><span style="font-style: italic;">&nbsp; Two synchronous serial interface (SSI) controllers for I</span><sup style="font-style: italic;">2</sup><span style="font-style: italic;">S or AC97&nbsp;&nbsp; <br>&nbsp; audio     inputs/outputs</span><br style="font-style: italic;"></div><div style="text-align: left;">while in MPC5200b's feature there's only:<br>&nbsp; <span style="font-style: italic;">I</span><small style="font-style: italic;"><sup>2</sup></small><span style="font-style: italic;">S (up to
 three)<br></span>However the main difference features:<br>MPC5200B: <a href="http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5200B&amp;nodeId=0162468rH3bTdG0898">http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5200B&amp;nodeId=0162468rH3bTdG0898</a><br>MPC8610:<br><a href="http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC8610">http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC8610</a><br><br>What do you think on this difference?<br><span style="font-style: italic;"></span></div><BR><BR><p>&#32;



      <hr size=1><font face="Arial" size="2"><hr size=1><font face="Arial" size="2">L'email della prossima generazione? Puoi averla con la <a href="http://us.rd.yahoo.com/mail/it/taglines/hotmail/nowyoucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">nuova Yahoo! Mail</a></font>
--0-1816320898-1204626408=:28874--
