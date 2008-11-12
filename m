Return-Path: <jcherukuri_necc@yahoo.com>
Received: from web110312.mail.gq1.yahoo.com (web110312.mail.gq1.yahoo.com
	[67.195.8.212]) by ozlabs.org (Postfix) with SMTP id AEA9DDDD04
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Nov 2008 08:10:43 +1100 (EST)
Date: Wed, 12 Nov 2008 13:03:59 -0800 (PST)
From: Jyotshna Cherukuri <jcherukuri_necc@yahoo.com>
Subject: problems loading 2.6.25 kernel onto PQ2FADS-VR board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1036875131-1226523839=:67373"
Message-ID: <204868.67373.qm@web110312.mail.gq1.yahoo.com>
Reply-To: jcherukuri_necc@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1036875131-1226523839=:67373
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,


I have a PQ2FADS-VR board with 2.4.26 kernel running well on it which came =
with Metrworks PCS BSP pacakge and now I am trying to upgrade it to 2.6.25 =
version by using ltib and enabling PQ2FADS support in the kernel. I got the=
 kernel built successfully and when I try to=A0 load it onto the board whic=
h has u-boot-1.3.2 version in 8 M FLASH SIMM i encounter the following erro=
r.

tftpboot 400000 uImage

[snip]

Bytes transferred =3D 1624909 (18cb4d hex)

=3D> tftpboot 800000 pq2fads.dtb

[snip]

Bytes transferred =3D 12288 (3000 hex)

=3D> bootm 400000 - 800000

## Booting image at 00400000 ...

=A0=A0 Image Name:=A0=A0 Linux-2.6.25

=A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)

=A0=A0 Data Size:=A0=A0=A0 1624845 Bytes =3D=A0 1.5 MB

=A0=A0 Load Address: 00000000

=A0=A0 Entry Point:=A0 00000000

=A0=A0 Verifying Checksum ... OK

=A0=A0 Uncompressing Kernel Image ... OK

=A0=A0 Booting using the fdt at 0x800000

=A0=A0 Loading Device Tree to 007fc000, end 007fefff ... OK



And Then it stops. The board doesn't print anything else.
Can anyone please help me to whats going on and to what I need to=A0 enable=
 to see some debug info on the serial port ( minicom in my case ).=20

P.S :=A0 I did enable all the early level debugging in the kernel but yet I=
 dont see anything on the console.

Any help is greatly appreciated.

Thanks in advance

Regards
Jyotshna

=0A=0A=0A      
--0-1036875131-1226523839=:67373
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Hi ,<br><br><br>I have a PQ2FADS-VR board with 2.4.26 kernel running well on it which came with Metrworks PCS BSP pacakge and now I am trying to upgrade it to 2.6.25 version by using ltib and enabling PQ2FADS support in the kernel. I got the kernel built successfully and when I try to&nbsp; load it onto the board which has u-boot-1.3.2 version in 8 M FLASH SIMM i encounter the following error.<br><br><tt>tftpboot 400000 uImage</tt><br>
<tt>[snip]</tt><br>
<tt>Bytes transferred = 1624909 (18cb4d hex)</tt><br>
<tt>=&gt; tftpboot 800000 pq2fads.dtb</tt><br>
<tt>[snip]</tt><br>
<tt>Bytes transferred = 12288 (3000 hex)</tt><br>
<tt>=&gt; bootm 400000 - 800000</tt><br>
<tt>## Booting image at 00400000 ...</tt><br>
<tt>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.25</tt><br>
<tt>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)</tt><br>
<tt>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1624845 Bytes =&nbsp; 1.5 MB</tt><br>
<tt>&nbsp;&nbsp; Load Address: 00000000</tt><br>
<tt>&nbsp;&nbsp; Entry Point:&nbsp; 00000000</tt><br>
<tt>&nbsp;&nbsp; Verifying Checksum ... OK</tt><br>
<tt>&nbsp;&nbsp; Uncompressing Kernel Image ... OK</tt><br>
<tt>&nbsp;&nbsp; Booting using the fdt at 0x800000</tt><br>
<tt>&nbsp;&nbsp; Loading Device Tree to 007fc000, end 007fefff ... OK</tt><br>
<br>
<tt>And Then it stops. The board doesn't print anything else.</tt>
Can anyone please help me to whats going on and to what I need to&nbsp; enable to see some debug info on the serial port ( minicom in my case ). <br><br>P.S :&nbsp; I did enable all the early level debugging in the kernel but yet I dont see anything on the console.<br><br>Any help is greatly appreciated.<br><br>Thanks in advance<br><br>Regards<br>Jyotshna<br><br></td></tr></table><br>

      
--0-1036875131-1226523839=:67373--
