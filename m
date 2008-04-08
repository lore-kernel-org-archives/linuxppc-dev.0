Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 4E21FDDDFA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 21:30:34 +1000 (EST)
Message-ID: <47FB5758.5080303@matrix-vision.de>
Date: Tue, 08 Apr 2008 13:30:32 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: [Fwd: Re: MPC8343 - "unable to handle paging request @ 0"]
Content-Type: multipart/alternative;
	boundary="------------090305010801020600000609"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090305010801020600000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

sorry - forgot Kim + List

-------- Original-Nachricht --------
Betreff: 	Re: MPC8343 - "unable to handle paging request @ 0"
Datum: 	Tue, 08 Apr 2008 13:29:20 +0200
Von: 	Andre Schwarz <andre.schwarz@matrix-vision.de>
An: 	Scott Wood <scottwood@freescale.com>
Referenzen: 	<47F73625.9040903@matrix-vision.de>=20
<20080407161036.GA2688@loki.buserror.net>



Scott Wood schrieb:
> On Sat, Apr 05, 2008 at 10:19:49AM +0200, Andr=E9 Schwarz wrote:
>  =20
>> Kernel starts and crashes with "unable to handle kernel paging request=
 @ =20
>> 00000000".
>>
>> After turning debug on in some files I can see that the initrd memory =
=20
>> gets reserved and the dtb is parsed correctly.
>> PCI memory/io spaces are set up fine.
>>
>> At first I thought this is a problem with the device tree since the ca=
ll =20
>> trace always points to "of_"-functions and "strcmp".
>>    =20
>
> Could you provide this call trace?
>
> -Scott
>  =20
Scott,

after removing "mpc834x_usb_cfg()" from my "mvblm7_setup_arch()" the=20
crash is delayed ...


regards,
Andre



System-map :

c0012098 T strcpy
c00120b4 T strncpy
c00120f4 T strcat
c0012120 T strcmp
c0012144 T strlen
...
c00ecd08 T of_find_property
c00ecda4 T of_get_property
c00ecdd8 T of_n_size_cells

console [udbg0] enabled
setup_arch: bootmem
mvblm7_setup_arch()
arch: exit
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   131072
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1300=
48
Kernel command line: root=3D/dev/ram ro rootfstype=3Dsquashfs
PID hash table entries: 2048 (order: 11, 8192 bytes)
clocksource: timebase mult[3c00001] shift[22] registered
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0012128
Oops: Kernel access of bad area, sig: 11 [#1]
mvBlueLYNX-M7
Modules linked in:
NIP: c0012128 LR: c00ecd44 CTR: 00000007
REGS: c0193ec0 TRAP: 0300   Not tainted  (2.6.25-rc8-01197-g1de15bb-dirty=
)
MSR: 00009032 <EE,ME,IR,DR>  CR: 48002048  XER: 00000000
DAR: 00000000, DSISR: 20000000
TASK =3D c0182510[0] 'swapper' THREAD: c0192000
GPR00: c00ecdb4 c0193f70 c0182510 00000000 c01401c7 ffffffff c017a808=20
c00db350
GPR08: 00000000 c0180000 000a2c20 c017d3f4 48000042 ffffdfd7 1fffd000=20
00000000
GPR16: ffffdfd7 ffffdfd7 00000000 00000000 1fff8974 1ff426f8 00000004=20
00288000
GPR24: 00000000 00000000 c0198fa0 c0190000 c0190000 00000000 c01401c8=20
dfffffa8
Call Trace:
[c0193f70] [00001111]  (unreliable)
[c0193f90] [c00ecdb4]
[c0193fa0] [c016df50]
[c0193fb0] [c017705c]
[c0193fc0] [c01646b4]
[c0193ff0] [00003438]
Instruction dump:
3884ffff 8c050001 2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001
4082fff4 4e800020 38a3ffff 3884ffff <8c650001> 2c830000 8c040001 7c601851
---[ end trace 8640abe69a316dee ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..                 =20



MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------090305010801020600000609
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
sorry - forgot Kim + List<br>
<br>
-------- Original-Nachricht --------
<table class="moz-email-headers-table" border="0" cellpadding="0"
 cellspacing="0">
  <tbody>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Betreff: </th>
      <td>Re: MPC8343 - "unable to handle paging request @ 0"</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Datum: </th>
      <td>Tue, 08 Apr 2008 13:29:20 +0200</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Von: </th>
      <td>Andre Schwarz <a class="moz-txt-link-rfc2396E" href="mailto:andre.schwarz@matrix-vision.de">&lt;andre.schwarz@matrix-vision.de&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">An: </th>
      <td>Scott Wood <a class="moz-txt-link-rfc2396E" href="mailto:scottwood@freescale.com">&lt;scottwood@freescale.com&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Referenzen: </th>
      <td><a class="moz-txt-link-rfc2396E" href="mailto:47F73625.9040903@matrix-vision.de">&lt;47F73625.9040903@matrix-vision.de&gt;</a>
<a class="moz-txt-link-rfc2396E" href="mailto:20080407161036.GA2688@loki.buserror.net">&lt;20080407161036.GA2688@loki.buserror.net&gt;</a></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
Scott Wood schrieb:
<blockquote cite="mid:20080407161036.GA2688@loki.buserror.net"
 type="cite">
  <pre wrap="">On Sat, Apr 05, 2008 at 10:19:49AM +0200, Andr&eacute; Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Kernel starts and crashes with "unable to handle kernel paging request @  
00000000".

After turning debug on in some files I can see that the initrd memory  
gets reserved and the dtb is parsed correctly.
PCI memory/io spaces are set up fine.

At first I thought this is a problem with the device tree since the call  
trace always points to "of_"-functions and "strcmp".
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Could you provide this call trace?

-Scott
  </pre>
</blockquote>
Scott,<br>
<br>
after removing "mpc834x_usb_cfg()" from my "mvblm7_setup_arch()" the
crash is delayed ...<br>
<br>
<br>
regards,<br>
Andre<br>
<br>
<br>
<br>
System-map :<br>
<br>
c0012098 T strcpy<br>
c00120b4 T strncpy<br>
c00120f4 T strcat<br>
c0012120 T strcmp<br>
c0012144 T strlen<br>
...<br>
c00ecd08 T of_find_property<br>
c00ecda4 T of_get_property<br>
c00ecdd8 T of_n_size_cells<br>
<br>
console [udbg0] enabled<br>
setup_arch: bootmem<br>
mvblm7_setup_arch()<br>
arch: exit<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp; 131072<br>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp; 131072 -&gt;&nbsp;&nbsp; 131072<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp; 131072<br>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages:
130048<br>
Kernel command line: root=/dev/ram ro rootfstype=squashfs<br>
PID hash table entries: 2048 (order: 11, 8192 bytes)<br>
clocksource: timebase mult[3c00001] shift[22] registered<br>
Unable to handle kernel paging request for data at address 0x00000000<br>
Faulting instruction address: 0xc0012128<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
mvBlueLYNX-M7<br>
Modules linked in:<br>
NIP: c0012128 LR: c00ecd44 CTR: 00000007<br>
REGS: c0193ec0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;
(2.6.25-rc8-01197-g1de15bb-dirty)<br>
MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 48002048&nbsp; XER: 00000000<br>
DAR: 00000000, DSISR: 20000000<br>
TASK = c0182510[0] 'swapper' THREAD: c0192000<br>
GPR00: c00ecdb4 c0193f70 c0182510 00000000 c01401c7 ffffffff c017a808
c00db350<br>
GPR08: 00000000 c0180000 000a2c20 c017d3f4 48000042 ffffdfd7 1fffd000
00000000<br>
GPR16: ffffdfd7 ffffdfd7 00000000 00000000 1fff8974 1ff426f8 00000004
00288000<br>
GPR24: 00000000 00000000 c0198fa0 c0190000 c0190000 00000000 c01401c8
dfffffa8<br>
Call Trace:<br>
[c0193f70] [00001111]&nbsp; (unreliable)<br>
[c0193f90] [c00ecdb4]<br>
[c0193fa0] [c016df50]<br>
[c0193fb0] [c017705c]<br>
[c0193fc0] [c01646b4]<br>
[c0193ff0] [00003438]<br>
Instruction dump:<br>
3884ffff 8c050001 2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001<br>
4082fff4 4e800020 38a3ffff 3884ffff &lt;8c650001&gt; 2c830000 8c040001
7c601851<br>
---[ end trace 8640abe69a316dee ]---<br>
Kernel panic - not syncing: Attempted to kill the idle task!<br>
Rebooting in 180 seconds..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------090305010801020600000609--
