Return-Path: <johndavi@us.ibm.com>
In-Reply-To: <000801c5aea9$059f01e0$fa0cc9ca@lcj3bdfa4e34dd>
To: "lily" <lichanjuan04@st.lzu.edu.cn>
MIME-Version: 1.0
Message-ID: <OF4A6E57B7.047A8CB6-ON8725706F.00264CE2-C125706F.00264A01@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Thu, 1 Sep 2005 08:58:58 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 002649FCC125706F_="
Cc: linuxppc-embedded-bounces@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: linux hangs after uncompress kernel image
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 002649FCC125706F_=
Content-Type: text/plain; charset="US-ASCII"

Hello Lily,

Maybe you could try to put in some printk's and see which line of code 
generates an exception.

JD



"lily" <lichanjuan04@st.lzu.edu.cn> 
Sent by: linuxppc-embedded-bounces@ozlabs.org
09/01/2005 05:55 AM

To
<linuxppc-embedded@ozlabs.org>
cc

Subject
linux hangs after uncompress kernel image






i work on octobusHPPC405EP board . when I try to bring up the kernel i 
meet the problem that linux hangs after uncompressing image:
 
U-Boot 1.1.2 (Jun  3 2005 - 12:05:48)
 
CPU:   IBM PowerPC 405EP Rev. B at 133.333 MHz (PLB=133, OPB=66, EBC=33 
MHz)
       IIC Boot EEPROM disabled
       PCI async ext clock used, internal PCI arbiter enabled
       16 kB I-Cache 16 kB D-Cache
OCTOBUS Board: ### No HW ID - assuming OCTOBUS HPPC405
I2C:   ready
DRAM:  32 MB
FLASH:  4 MB
=>iminfo 1000000
## Checking Image at 01000000 ...
   Image Name:   Linux-2.4.21-pre5
   Created:      2005-08-03  17:45:20 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    548345 Bytes = 535.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
=> bootm 1000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.4.21-pre5
   Created:      2005-08-03  17:45:20 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    548345 Bytes = 535.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
 
<hang>
what's the problem?? _______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=_alternative 002649FCC125706F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello Lily,</font>
<br>
<br><font size=2 face="sans-serif">Maybe you could try to put in some printk's
and see which line of code generates an exception.</font>
<br>
<br><font size=2 face="sans-serif">JD</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>&quot;lily&quot; &lt;lichanjuan04@st.lzu.edu.cn&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces@ozlabs.org</font>
<p><font size=1 face="sans-serif">09/01/2005 05:55 AM</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td valign=top><font size=1 face="sans-serif">&lt;linuxppc-embedded@ozlabs.org&gt;</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td valign=top>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td valign=top><font size=1 face="sans-serif">linux hangs after uncompress
kernel image</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2 face="sans-serif">i work on octobusHPPC405EP board . when
I try to bring up the kernel i meet the problem that linux hangs after
uncompressing image:</font>
<br><font size=3 face="sans-serif">&nbsp;</font>
<br><font size=2 face="sans-serif">U-Boot 1.1.2 (Jun &nbsp;3 2005 - 12:05:48)</font>
<br><font size=3 face="sans-serif">&nbsp;</font>
<br><font size=2 face="sans-serif">CPU: &nbsp; IBM PowerPC 405EP Rev. B
at 133.333 MHz (PLB=133, OPB=66, EBC=33 MHz)<br>
 &nbsp; &nbsp; &nbsp; IIC Boot EEPROM disabled<br>
 &nbsp; &nbsp; &nbsp; PCI async ext clock used, internal PCI arbiter enabled<br>
 &nbsp; &nbsp; &nbsp; 16 kB I-Cache 16 kB D-Cache<br>
OCTOBUS Board: ### No HW ID - assuming OCTOBUS HPPC405<br>
I2C: &nbsp; ready<br>
DRAM: &nbsp;32 MB<br>
FLASH: &nbsp;4 MB</font>
<br><font size=2 face="sans-serif">=&gt;iminfo 1000000</font>
<br><font size=2 face="sans-serif">## Checking Image at 01000000 ...<br>
 &nbsp; Image Name: &nbsp; Linux-2.4.21-pre5<br>
 &nbsp; Created: &nbsp; &nbsp; &nbsp;2005-08-03 &nbsp;17:45:20 UTC<br>
 &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
 &nbsp; Data Size: &nbsp; &nbsp;548345 Bytes = 535.5 kB<br>
 &nbsp; Load Address: 00000000<br>
 &nbsp; Entry Point: &nbsp;00000000<br>
 &nbsp; Verifying Checksum ... OK<br>
=&gt; bootm 1000000<br>
## Booting image at 01000000 ...<br>
 &nbsp; Image Name: &nbsp; Linux-2.4.21-pre5<br>
 &nbsp; Created: &nbsp; &nbsp; &nbsp;2005-08-03 &nbsp;17:45:20 UTC<br>
 &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
 &nbsp; Data Size: &nbsp; &nbsp;548345 Bytes = 535.5 kB<br>
 &nbsp; Load Address: 00000000<br>
 &nbsp; Entry Point: &nbsp;00000000<br>
 &nbsp; Verifying Checksum ... OK<br>
 &nbsp; Uncompressing Kernel Image ... OK</font><font size=3 face="sans-serif"><br>
 </font>
<br><font size=2 face="sans-serif">&lt;hang&gt;</font>
<br><font size=2 face="sans-serif">what's the problem?? </font><font size=2><tt>_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</tt></font>
<br>
--=_alternative 002649FCC125706F_=--
