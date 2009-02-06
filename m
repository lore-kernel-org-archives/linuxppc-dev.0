Return-Path: <kau@bang-olufsen.dk>
In-Reply-To: <200902060824.06851.david.jander@protonic.nl>
To: David Jander <david.jander@protonic.nl>
Subject: Re: MPC5121e, MBX driver, pvr.ko ...
MIME-Version: 1.0
Message-ID: <OF4A842FE5.CCF31A69-ONC1257555.0030E2A2-C1257555.0031CBC3@bang-olufsen.dk>
From: Klaus Pedersen <kau@bang-olufsen.dk>
Date: Fri, 6 Feb 2009 10:03:55 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 0031CBC2C1257555_="
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linuxppc-dev-bounces+kau=bang-olufsen.dk@ozlabs.org,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_alternative 0031CBC2C1257555_=
Content-Type: text/plain; charset="US-ASCII"

Hi David

I'm also run on a custom board, and using the MBX. 

You need to get the device tree file right. You will see the MBX reserved 
the irq 66 in the boot printout.
Instead of using insmod use modprobe. The are 2 versions of rc.pvr.

Best Regard
Klaus Pedersen

I a early thread about memcpy for G2/G3 cores, you mentioned that you will 
have a look at the init. of the dram controller and the prio-manager, did 
that give you anything??





David Jander <david.jander@protonic.nl> 
Sent by: linuxppc-dev-bounces+kau=bang-olufsen.dk@ozlabs.org
06-02-2009 08:53

To
"Linuxppc-dev" <Linuxppc-dev@ozlabs.org>
cc
John Rigby <jrigby@freescale.com>
Subject
MPC5121e, MBX driver, pvr.ko ...







Hi all,

I have a custom board with a MPC5121e (rev 1.5) on it. It is the latest 
git 
kernel from denx ads5121 head with our BSP mixed in.

I decided to try out Application Note AN3793 from Freescale (3D Graphics 
on 
the ADS512101 Board Using OpenGL ES).

I started trying to load the provided (binary!) kernel modules into our 
kernel, but I am geeting errors inserting the modules using 
insmod: 'clcdc.ko' complains about not being able to register de device 
major 
number, and 'dbgdrv.ko' oopses with a BUG() in percpu_modfree()! This 
function should never be called in a non-SMP kernel, so I suspect there 
are 
some important differences between the kernel I have and the one the 
binary-only drivers where built against :-(

In another approach I managed to load the provided kernel binary (which is 

built for the ADS512101 evaluation board) on our platform, by tweaking our 

device-tree until it booted without crashing. In the end I was able to 
load 
all the modules and run the OpenGL-ES demo programs.
I can't believe this is the intended way of doing this, so I'd like to 
know if 
there is someone else who has managed to get the MBX running OpenGL-ES on 
a 
custom board with a custom build of the kernel.

Note: the kernel version number is still the same: 2.6.24.6, only 
difference 
AFAIK is some minor unrelated patches to drivers for other MPC5121 SoC 
devices, and probably some different configuration options. Apparently 
this 
is enough to break binary compatibility for the drivers :-(

Any hint is appreciated...

Best regards,

-- 
David Jander
Protonic Holland.
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



--=_alternative 0031CBC2C1257555_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi David</font>
<br>
<br><font size=2 face="sans-serif">I'm also run on a custom board, and
using the MBX. </font>
<br>
<br><font size=2 face="sans-serif">You need to get the device tree file
right. You will see the MBX reserved the irq 66 in the boot printout.</font>
<br><font size=2 face="sans-serif">Instead of using insmod use modprobe.
The are 2 versions of rc.pvr.</font>
<br>
<br><font size=2 face="sans-serif">Best Regard</font>
<br><font size=2 face="sans-serif">Klaus Pedersen</font>
<br>
<br><font size=2 face="sans-serif">I a early thread about memcpy for G2/G3
cores, you mentioned that you will have a look at the init. of the dram
controller and the prio-manager, did that give you anything??</font>
<br>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>David Jander &lt;david.jander@protonic.nl&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-dev-bounces+kau=bang-olufsen.dk@ozlabs.org</font>
<p><font size=1 face="sans-serif">06-02-2009 08:53</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&quot;Linuxppc-dev&quot; &lt;Linuxppc-dev@ozlabs.org&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">John Rigby &lt;jrigby@freescale.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">MPC5121e, MBX driver, pvr.ko ...</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2><br>
Hi all,<br>
<br>
I have a custom board with a MPC5121e (rev 1.5) on it. It is the latest
git <br>
kernel from denx ads5121 head with our BSP mixed in.<br>
<br>
I decided to try out Application Note AN3793 from Freescale (3D Graphics
on <br>
the ADS512101 Board Using OpenGL ES).<br>
<br>
I started trying to load the provided (binary!) kernel modules into our
<br>
kernel, but I am geeting errors inserting the modules using <br>
insmod: 'clcdc.ko' complains about not being able to register de device
major <br>
number, and 'dbgdrv.ko' oopses with a BUG() in percpu_modfree()! This <br>
function should never be called in a non-SMP kernel, so I suspect there
are <br>
some important differences between the kernel I have and the one the <br>
binary-only drivers where built against :-(<br>
<br>
In another approach I managed to load the provided kernel binary (which
is <br>
built for the ADS512101 evaluation board) on our platform, by tweaking
our <br>
device-tree until it booted without crashing. In the end I was able to
load <br>
all the modules and run the OpenGL-ES demo programs.<br>
I can't believe this is the intended way of doing this, so I'd like to
know if <br>
there is someone else who has managed to get the MBX running OpenGL-ES
on a <br>
custom board with a custom build of the kernel.<br>
<br>
Note: the kernel version number is still the same: 2.6.24.6, only difference
<br>
AFAIK is some minor unrelated patches to drivers for other MPC5121 SoC
<br>
devices, and probably some different configuration options. Apparently
this <br>
is enough to break binary compatibility for the drivers :-(<br>
<br>
Any hint is appreciated...<br>
<br>
Best regards,<br>
<br>
-- <br>
David Jander<br>
Protonic Holland.<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
Linuxppc-dev@ozlabs.org<br>
</font></tt><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev"><tt><font size=2>https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
<br>
</font></tt></a>
<br>
--=_alternative 0031CBC2C1257555_=--
