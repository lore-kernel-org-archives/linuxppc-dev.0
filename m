Return-Path: <ravi.rao@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 41D89DDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 01:28:42 +1000 (EST)
In-Reply-To: <20070822151523.AF7A910A0071@mail78-dub.bigfish.com>
To: wolfgang.reissnegger@xilinx.com
Subject: Re: Kerenel crashes every other Boot..
MIME-Version: 1.0
Message-ID: <OFB4F00B2A.B7C79F45-ON8525733F.00547516-8525733F.0054E4E5@rflelect.com>
From: ravi.rao@rflelect.com
Date: Wed, 22 Aug 2007 11:28:19 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 0054E4E48525733F_="
Cc: linuxppc-embedded@ozlabs.org
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
--=_alternative 0054E4E48525733F_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
  Some times it crashes and many times it comes back with an error as Junk 
in compressed Image..
Below is the screen dump..
**************** When it does not work **************************
BOOT MONITOR:
.. eth driver not initialized. command aborted
.. Invoking Linux PPC Kernel Loader at 0xfe800000
.. Boot Parms: 0x3f72314, Flags: 0x1014, Verbose: 0x3

loaded at:     FE800000 FEA16124
relocated to:  00400000 00616124
board data at: 03F72314 03F72510
relocated to:  00613000 006131FC
zimage at:     00404EDC 0061289C
avail ram:     00617000 04000000

Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.21 (root@localhost.localdomain) (gcc version 4.1.0 
20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4
2 EDT 2007
MAC 0: 00:50:cc:0c:e2:30
MAC 1: 00:50:c2:0c:e2:31
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists.  Total pages: 16256
Kernel command line: console=ttyS0,9600 root=/dev/rd/0 
ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61952k available (1188k kernel code, 280k data, 1504k init, 0k 
highmem)
Mount-cache hash table entries: 512
Kernel panic - not syncing: junk in compressed archive
Rebooting in 180 seconds..

******************** When it works **************************
BOOT MONITOR:
.. eth driver not initialized. command aborted
.. Invoking Linux PPC Kernel Loader at 0xfe800000
.. Boot Parms: 0x3f72314, Flags: 0x1014, Verbose: 0x3

loaded at:     FE800000 FEA16124
relocated to:  00400000 00616124
board data at: 03F72314 03F72510
relocated to:  00613000 006131FC
zimage at:     00404EDC 0061289C
avail ram:     00617000 04000000

Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.21 (root@localhost.localdomain) (gcc version 4.1.0 
20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4
2 EDT 2007
MAC 0: 00:50:cc:0c:e2:30
MAC 1: 00:50:c2:0c:e2:31
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists.  Total pages: 16256
Kernel command line: console=ttyS0,9600 root=/dev/rd/0 
ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61952k available (1188k kernel code, 280k data, 1504k init, 0k 
highmem)
Mount-cache hash table entries: 512
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
RAMDISK driver initialized: 1 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
i2c /dev entries driver
IBM IIC driver v2.1
ibm-iic0: using standard (100 kHz) mode
Freeing unused kernel memory: 1504k init
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.60.2 (2003.04.29-11:32+0000) multi-call binary
Bummer, could not run '/etc/init.d/rcS': No such file or directory

Please press Enter to activate this console.
sh-2.05#

Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 



Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> 
08/22/2007 11:15 AM

To
ravi.rao@rflelect.com
cc
linuxppc-embedded@ozlabs.org
Subject
Re: Kerenel crashes every other Boot..






Hi Ravi,

you need to provide more information, for example, where does the kernel
crash, any serial console output that you see when it crashes, etc.

Cheers,
   Wolfgang


ravi.rao@rflelect.com wrote:
> 
> Hi All,
>     I have a PPC 405EP custom target. I based most of my software on the
> EP405 Taihu reference and now I am able to load the 2.6.21 kernel and
> with a minimum initramfs I also get the busy box prompt. I see a strange
> poblem it fails(linux crashes) every other boot. Can any one please tell
> me what may be happening ???
> Thanks,
> Ravishankar Govindarao
> RFL Electronics Inc.
> E-mail : _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com>
> Voice: 973.334.3100 Ext. 233
> Fax: 973.334.3863
> 
> 
> 
> 
> _CONFIDENTIALITY NOTE_
> 
> This e-mail, including any attachments, may contain confidential and/or
> legally privileged information.  The Information is intended only for
> the use of the individual or entity named on this e-mail .  If you are
> not the intended recipient, you are hereby notified that any disclosure,
> copying, distribution, or the taking of any action in reliance on the
> contents of this transmitted Information is strictly prohibited. 
> Further, if you are not the intended recipient, please notify us by
> return e-mail and delete the Information promptly.
> 
> 
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded



--=_alternative 0054E4E48525733F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">&nbsp; Some times it crashes and many
times it comes back with an error as Junk in compressed Image..</font>
<br><font size=2 face="sans-serif">Below is the screen dump..</font>
<br><font size=2 face="sans-serif">**************** When it does not work
**************************</font>
<br><font size=2 face="Courier">BOOT MONITOR:</font>
<br><font size=2 face="Courier">.. eth driver not initialized. command
aborted</font>
<br><font size=2 face="Courier">.. Invoking Linux PPC Kernel Loader at
0xfe800000</font>
<br><font size=2 face="Courier">.. Boot Parms: 0x3f72314, Flags: 0x1014,
Verbose: 0x3</font>
<br>
<br><font size=2 face="Courier">loaded at: &nbsp; &nbsp; FE800000 FEA16124</font>
<br><font size=2 face="Courier">relocated to: &nbsp;00400000 00616124</font>
<br><font size=2 face="Courier">board data at: 03F72314 03F72510</font>
<br><font size=2 face="Courier">relocated to: &nbsp;00613000 006131FC</font>
<br><font size=2 face="Courier">zimage at: &nbsp; &nbsp; 00404EDC 0061289C</font>
<br><font size=2 face="Courier">avail ram: &nbsp; &nbsp; 00617000 04000000</font>
<br>
<br><font size=2 face="Courier">Linux/PPC load: console=ttyS0,9600 ip=dhcp
root=nfs</font>
<br><font size=2 face="Courier">Uncompressing Linux...done.</font>
<br><font size=2 face="Courier">Now booting the kernel</font>
<br><font size=2 face="Courier">Linux version 2.6.21 (root@localhost.localdomain)
(gcc version 4.1.0 20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4</font>
<br><font size=2 face="Courier">2 EDT 2007</font>
<br><font size=2 face="Courier">MAC 0: 00:50:cc:0c:e2:30</font>
<br><font size=2 face="Courier">MAC 1: 00:50:c2:0c:e2:31</font>
<br><font size=2 face="Courier">Zone PFN ranges:</font>
<br><font size=2 face="Courier">&nbsp; DMA &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; 0 -&gt; &nbsp; &nbsp;16384</font>
<br><font size=2 face="Courier">&nbsp; Normal &nbsp; &nbsp; &nbsp;16384
-&gt; &nbsp; &nbsp;16384</font>
<br><font size=2 face="Courier">early_node_map[1] active PFN ranges</font>
<br><font size=2 face="Courier">&nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp; &nbsp;0
-&gt; &nbsp; &nbsp;16384</font>
<br><font size=2 face="Courier">Built 1 zonelists. &nbsp;Total pages: 16256</font>
<br><font size=2 face="Courier">Kernel command line: console=ttyS0,9600
root=/dev/rd/0 ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0</font>
<br><font size=2 face="Courier">PID hash table entries: 256 (order: 8,
1024 bytes)</font>
<br><font size=2 face="Courier">Dentry cache hash table entries: 8192 (order:
3, 32768 bytes)</font>
<br><font size=2 face="Courier">Inode-cache hash table entries: 4096 (order:
2, 16384 bytes)</font>
<br><font size=2 face="Courier">Memory: 61952k available (1188k kernel
code, 280k data, 1504k init, 0k highmem)</font>
<br><font size=2 face="Courier">Mount-cache hash table entries: 512</font>
<br><font size=2 face="Courier">Kernel panic - not syncing: junk in compressed
archive</font>
<br><font size=2 face="Courier">Rebooting in 180 seconds..</font><font size=2 face="sans-serif"><br>
</font>
<br><font size=2 face="Tms Rmn">******************** When it works **************************</font>
<br><font size=2 face="Courier">BOOT MONITOR:</font>
<br><font size=2 face="Courier">.. eth driver not initialized. command
aborted</font>
<br><font size=2 face="Courier">.. Invoking Linux PPC Kernel Loader at
0xfe800000</font>
<br><font size=2 face="Courier">.. Boot Parms: 0x3f72314, Flags: 0x1014,
Verbose: 0x3</font>
<br>
<br><font size=2 face="Courier">loaded at: &nbsp; &nbsp; FE800000 FEA16124</font>
<br><font size=2 face="Courier">relocated to: &nbsp;00400000 00616124</font>
<br><font size=2 face="Courier">board data at: 03F72314 03F72510</font>
<br><font size=2 face="Courier">relocated to: &nbsp;00613000 006131FC</font>
<br><font size=2 face="Courier">zimage at: &nbsp; &nbsp; 00404EDC 0061289C</font>
<br><font size=2 face="Courier">avail ram: &nbsp; &nbsp; 00617000 04000000</font>
<br>
<br><font size=2 face="Courier">Linux/PPC load: console=ttyS0,9600 ip=dhcp
root=nfs</font>
<br><font size=2 face="Courier">Uncompressing Linux...done.</font>
<br><font size=2 face="Courier">Now booting the kernel</font>
<br><font size=2 face="Courier">Linux version 2.6.21 (root@localhost.localdomain)
(gcc version 4.1.0 20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4</font>
<br><font size=2 face="Courier">2 EDT 2007</font>
<br><font size=2 face="Courier">MAC 0: 00:50:cc:0c:e2:30</font>
<br><font size=2 face="Courier">MAC 1: 00:50:c2:0c:e2:31</font>
<br><font size=2 face="Courier">Zone PFN ranges:</font>
<br><font size=2 face="Courier">&nbsp; DMA &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; 0 -&gt; &nbsp; &nbsp;16384</font>
<br><font size=2 face="Courier">&nbsp; Normal &nbsp; &nbsp; &nbsp;16384
-&gt; &nbsp; &nbsp;16384</font>
<br><font size=2 face="Courier">early_node_map[1] active PFN ranges</font>
<br><font size=2 face="Courier">&nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp; &nbsp;0
-&gt; &nbsp; &nbsp;16384</font>
<br><font size=2 face="Courier">Built 1 zonelists. &nbsp;Total pages: 16256</font>
<br><font size=2 face="Courier">Kernel command line: console=ttyS0,9600
root=/dev/rd/0 ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0</font>
<br><font size=2 face="Courier">PID hash table entries: 256 (order: 8,
1024 bytes)</font>
<br><font size=2 face="Courier">Dentry cache hash table entries: 8192 (order:
3, 32768 bytes)</font>
<br><font size=2 face="Courier">Inode-cache hash table entries: 4096 (order:
2, 16384 bytes)</font>
<br><font size=2 face="Courier">Memory: 61952k available (1188k kernel
code, 280k data, 1504k init, 0k highmem)</font>
<br><font size=2 face="Courier">Mount-cache hash table entries: 512</font>
<br><font size=2 face="Courier">JFFS2 version 2.2. (NAND) (C) 2001-2006
Red Hat, Inc.</font>
<br><font size=2 face="Courier">io scheduler noop registered</font>
<br><font size=2 face="Courier">io scheduler anticipatory registered</font>
<br><font size=2 face="Courier">io scheduler deadline registered</font>
<br><font size=2 face="Courier">io scheduler cfq registered (default)</font>
<br><font size=2 face="Courier">Serial: 8250/16550 driver $Revision: 1.90
$ 4 ports, IRQ sharing enabled</font>
<br><font size=2 face="Courier">serial8250: ttyS0 at MMIO 0x0 (irq = 0)
is a 16550A</font>
<br><font size=2 face="Courier">serial8250: ttyS1 at MMIO 0x0 (irq = 1)
is a 16550A</font>
<br><font size=2 face="Courier">RAMDISK driver initialized: 1 RAM disks
of 16384K size 1024 blocksize</font>
<br><font size=2 face="Courier">loop: loaded (max 8 devices)</font>
<br><font size=2 face="Courier">i2c /dev entries driver</font>
<br><font size=2 face="Courier">IBM IIC driver v2.1</font>
<br><font size=2 face="Courier">ibm-iic0: using standard (100 kHz) mode</font>
<br><font size=2 face="Courier">Freeing unused kernel memory: 1504k init</font>
<br><font size=2 face="Courier">serial console detected. &nbsp;Disabling
virtual terminals.</font>
<br><font size=2 face="Courier">init started: &nbsp;BusyBox v0.60.2 (2003.04.29-11:32+0000)
multi-call binary</font>
<br><font size=2 face="Courier">Bummer, could not run '/etc/init.d/rcS':
No such file or directory</font>
<br>
<br><font size=2 face="Courier">Please press Enter to activate this console.</font>
<br><font size=2 face="Courier">sh-2.05#</font>
<br>
<br><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Wolfgang Reissnegger &lt;wolfgang.reissnegger@xilinx.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">08/22/2007 11:15 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">ravi.rao@rflelect.com</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: Kerenel crashes every other Boot..</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>Hi Ravi,<br>
<br>
you need to provide more information, for example, where does the kernel<br>
crash, any serial console output that you see when it crashes, etc.<br>
<br>
Cheers,<br>
 &nbsp; Wolfgang<br>
<br>
<br>
ravi.rao@rflelect.com wrote:<br>
&gt; <br>
&gt; Hi All,<br>
&gt; &nbsp; &nbsp; I have a PPC 405EP custom target. I based most of my
software on the<br>
&gt; EP405 Taihu reference and now I am able to load the 2.6.21 kernel
and<br>
&gt; with a minimum initramfs I also get the busy box prompt. I see a strange<br>
&gt; poblem it fails(linux crashes) every other boot. Can any one please
tell<br>
&gt; me what may be happening ???<br>
&gt; Thanks,<br>
&gt; Ravishankar Govindarao<br>
&gt; RFL Electronics Inc.<br>
&gt; E-mail : _Ravi.Rao@rflelect.com_ &lt;mailto:Ravi.Rao@rflelect.com&gt;<br>
&gt; Voice: 973.334.3100 Ext. 233<br>
&gt; Fax: 973.334.3863<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; <br>
&gt; _CONFIDENTIALITY NOTE_<br>
&gt; <br>
&gt; This e-mail, including any attachments, may contain confidential and/or<br>
&gt; legally privileged information. &nbsp;The Information is intended
only for<br>
&gt; the use of the individual or entity named on this e-mail . &nbsp;If
you are<br>
&gt; not the intended recipient, you are hereby notified that any disclosure,<br>
&gt; copying, distribution, or the taking of any action in reliance on
the<br>
&gt; contents of this transmitted Information is strictly prohibited. <br>
&gt; Further, if you are not the intended recipient, please notify us by<br>
&gt; return e-mail and delete the Information promptly.<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; <br>
&gt; ------------------------------------------------------------------------<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Linuxppc-embedded mailing list<br>
&gt; Linuxppc-embedded@ozlabs.org<br>
&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
<br>
</tt></font>
<br>
--=_alternative 0054E4E48525733F_=--
