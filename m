Return-Path: <mani_kandan@infosys.com>
Received: from KECGATE08.infosys.com (Kecgate08.infosysconsulting.com
	[122.98.10.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "kecgate08.infosys.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C11BB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 20:23:52 +1100 (EST)
From: Mani Kandan <mani_kandan@infosys.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 25 Nov 2009 14:38:52 +0530
Subject: Compilation issue with 2.6.22 on ppc machine
Message-ID: <9F4917E46EC4A64C8E5C28480A43EBA50BB079FE05@BLRKECMBX02.ad.infosys.com>
Content-Type: multipart/alternative;
	boundary="_000_9F4917E46EC4A64C8E5C28480A43EBA50BB079FE05BLRKECMBX02ad_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_9F4917E46EC4A64C8E5C28480A43EBA50BB079FE05BLRKECMBX02ad_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello All,

  I'm unable to compile my custom kernel version 2.6.22.5 after applying re=
al time patch 2.6.22.1-rt9.  I get following compilation errors:

In file included from arch/ppc/include/asm/hw_irq.h:121,
                 from include/asm/system.h:9,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/linux/irqflags.h:92:1: warning: "raw_local_irq_save" redefined
In file included from include/asm/system.h:9,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
arch/ppc/include/asm/hw_irq.h:114:1: warning: this is the location of the p=
revious definition
In file included from arch/ppc/include/asm/hw_irq.h:121,
                 from include/asm/system.h:9,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/linux/irqflags.h:97:1: warning: "raw_local_irq_restore" redefined
In file included from include/asm/system.h:9,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
arch/ppc/include/asm/hw_irq.h:73:1: warning: this is the location of the pr=
evious definition
In file included from include/linux/spinlock.h:108,
                 from include/linux/signal.h:9,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/asm/spinlock.h: In function '__raw_spin_lock':
include/asm/spinlock.h:34: error: 'raw_spinlock_t' has no member named 'slo=
ck'
include/asm/spinlock.h: In function '__raw_spin_unlock':
include/asm/spinlock.h:41: error: 'raw_spinlock_t' has no member named 'slo=
ck'
include/asm/spinlock.h: In function '__raw_read_trylock':
include/asm/spinlock.h:74: error: 'raw_rwlock_t' has no member named 'lock'
include/asm/spinlock.h: In function '__raw_read_lock':
include/asm/spinlock.h:97: error: 'raw_rwlock_t' has no member named 'lock'
include/asm/spinlock.h: In function '__raw_read_unlock':
include/asm/spinlock.h:113: error: 'raw_rwlock_t' has no member named 'lock=
'
include/asm/spinlock.h: In function '__raw_write_trylock':
include/asm/spinlock.h:131: error: 'raw_rwlock_t' has no member named 'lock=
'
include/asm/spinlock.h: In function '__raw_write_lock':
include/asm/spinlock.h:154: error: 'raw_rwlock_t' has no member named 'lock=
'
include/asm/spinlock.h: In function '__raw_write_unlock':
include/asm/spinlock.h:161: error: 'raw_rwlock_t' has no member named 'lock=
'
arch/ppc/kernel/asm-offsets.c: In function 'main':
arch/ppc/kernel/asm-offsets.c:147: error: 'struct vdso_data' has no member =
named 'tb_orig_stamp'
arch/ppc/kernel/asm-offsets.c:148: error: 'struct vdso_data' has no member =
named 'tb_ticks_per_sec'
arch/ppc/kernel/asm-offsets.c:149: error: 'struct vdso_data' has no member =
named 'tb_to_xs'
arch/ppc/kernel/asm-offsets.c:150: error: 'struct vdso_data' has no member =
named 'stamp_xsec'
arch/ppc/kernel/asm-offsets.c:151: error: 'struct vdso_data' has no member =
named 'tb_update_count'
arch/ppc/kernel/asm-offsets.c:152: error: 'struct vdso_data' has no member =
named 'tz_minuteswest'
arch/ppc/kernel/asm-offsets.c:153: error: 'struct vdso_data' has no member =
named 'tz_dsttime'
arch/ppc/kernel/asm-offsets.c:155: error: 'struct vdso_data' has no member =
named 'wtom_clock_sec'
arch/ppc/kernel/asm-offsets.c:156: error: 'struct vdso_data' has no member =
named 'wtom_clock_nsec'
make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
[root@dvl linux-rt]#

Is this a known issue ?

TIA,
Mani


--_000_9F4917E46EC4A64C8E5C28480A43EBA50BB079FE05BLRKECMBX02ad_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hello All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp; I&#8217;m unable to compile my custom kernel vers=
ion
2.6.22.5 after applying real time patch 2.6.22.1-rt9. &nbsp;I get following
compilation errors:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>In file included from arch/ppc/include/asm/hw_irq.h:121,=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/asm/system.h:9,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/list.h:9,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/signal.h:8,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from arch/ppc/kernel/asm-offsets.c:11:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/linux/irqflags.h:92:1: warning:
&quot;raw_local_irq_save&quot; redefined<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>In file included from include/asm/system.h:9,<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/list.h:9,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/linux/signal.h:8,<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from arch/ppc/kernel/asm-offsets.c:11:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/include/asm/hw_irq.h:114:1: warning: this is th=
e
location of the previous definition<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>In file included from arch/ppc/include/asm/hw_irq.h:121,=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/asm/system.h:9,<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/list.h:9,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/signal.h:8,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from arch/ppc/kernel/asm-offsets.c:11:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/linux/irqflags.h:97:1: warning:
&quot;raw_local_irq_restore&quot; redefined<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>In file included from include/asm/system.h:9,<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/list.h:9,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/signal.h:8,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from arch/ppc/kernel/asm-offsets.c:11:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/include/asm/hw_irq.h:73:1: warning: this is the=
 location
of the previous definition<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>In file included from include/linux/spinlock.h:108,<o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from include/linux/signal.h:9,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from arch/ppc/kernel/asm-offsets.c:11:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_spin_lock':<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:34: error: 'raw_spinlock_t' has n=
o
member named 'slock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_spin_unlock':=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:41: error: 'raw_spinlock_t' has n=
o
member named 'slock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_read_trylock'=
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:74: error: 'raw_rwlock_t' has no
member named 'lock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_read_lock':<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:97: error: 'raw_rwlock_t' has no
member named 'lock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_read_unlock':=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:113: error: 'raw_rwlock_t' has no
member named 'lock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_write_trylock=
':<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:131: error: 'raw_rwlock_t' has no
member named 'lock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_write_lock':<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:154: error: 'raw_rwlock_t' has no
member named 'lock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h: In function '__raw_write_unlock'=
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>include/asm/spinlock.h:161: error: 'raw_rwlock_t' has no
member named 'lock'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c: In function 'main':<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:147: error: 'struct vdso_d=
ata'
has no member named 'tb_orig_stamp'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:148: error: 'struct vdso_d=
ata'
has no member named 'tb_ticks_per_sec'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:149: error: 'struct vdso_d=
ata'
has no member named 'tb_to_xs'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:150: error: 'struct vdso_d=
ata'
has no member named 'stamp_xsec'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:151: error: 'struct vdso_d=
ata'
has no member named 'tb_update_count'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:152: error: 'struct vdso_d=
ata'
has no member named 'tz_minuteswest'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:153: error: 'struct vdso_d=
ata'
has no member named 'tz_dsttime'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:155: error: 'struct vdso_d=
ata'
has no member named 'wtom_clock_sec'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>arch/ppc/kernel/asm-offsets.c:156: error: 'struct vdso_d=
ata'
has no member named 'wtom_clock_nsec'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1<o:p=
></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>make: *** [prepare0] Error 2<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[root@dvl linux-rt]#<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Is this a known issue ? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>TIA,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Mani<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_9F4917E46EC4A64C8E5C28480A43EBA50BB079FE05BLRKECMBX02ad_--
