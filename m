Return-Path: <rpoornar@yahoo.com>
Received: from web57006.mail.re3.yahoo.com (web57006.mail.re3.yahoo.com
	[66.196.97.110]) by ozlabs.org (Postfix) with SMTP id A8190DDFD3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 17:49:41 +1000 (EST)
Date: Tue, 16 Sep 2008 00:42:33 -0700 (PDT)
From: poornima r <rpoornar@yahoo.com>
Subject: dts file for ep8548A board
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1493887656-1221550953=:11077"
Message-ID: <462940.11077.qm@web57006.mail.re3.yahoo.com>
Cc: rpoornar@yahoo.com
Reply-To: rpoornar@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1493887656-1221550953=:11077
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,



I am working on ep8548A embedded planet board.

I am using mpc8548cds dtb file (mpc8548cds.dts file in
arch/powerpc/boot/dts directory of the kernel source) as my device tree
file.

I am tracing the kernel initilization path through BDI.=20

The BDI tracing is hanging in early_init_devtree ( in machine_init
function) if the r3 register (physical pointer to device tree block) is
not set to dtb file loaded location in RAM.=20

Once I set the r3 register manually in BDI (rm r3 <dtb file
location>) the kernel is passing machine_init function (passing
early_init_devtree( ) ).

I tried=A0 to statically set r3 register in head_fsl_booke.S=A0
file by using ori instruction but I was not able to set the r3 value to
dtb file RAM location.=20

Are any changes necessary in mps8548cds.dts for ep8548A board?

How do we and where should we set the r3 register value in head_fsl_booke.S=
 file for device tree initilization?



Thanks,

Poornima

=A0

=A0 =20



=A0

=0A=0A=0A      
--0-1493887656-1221550953=:11077
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Hi all,<br>
<br>
I am working on ep8548A embedded planet board.<br>
I am using mpc8548cds dtb file (mpc8548cds.dts file in
arch/powerpc/boot/dts directory of the kernel source) as my device tree
file.<br>
I am tracing the kernel initilization path through BDI. <br>
The BDI tracing is hanging in early_init_devtree ( in machine_init
function) if the r3 register (physical pointer to device tree block) is
not set to dtb file loaded location in RAM. <br>
Once I set the r3 register manually in BDI (rm r3 &lt;dtb file
location&gt;) the kernel is passing machine_init function (passing
early_init_devtree( ) ).<br>
I tried&nbsp; to statically set r3 register in head_fsl_booke.S&nbsp;
file by using ori instruction but I was not able to set the r3 value to
dtb file RAM location. <br>
Are any changes necessary in mps8548cds.dts for ep8548A board?<br>
How do we and where should we set the r3 register value in head_fsl_booke.S file for device tree initilization?<br>
<br>
Thanks,<br>
Poornima<br>
&nbsp;<br>
&nbsp;  <br>
<br>
&nbsp;<br>
</td></tr></table><br>



      
--0-1493887656-1221550953=:11077--
