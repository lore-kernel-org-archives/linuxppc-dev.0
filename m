Return-Path: <lagrange@fr.oleane.com>
Received: from relay01s.ntr.oleane.net (relay01s.ntr.oleane.net [194.2.3.145])
	by ozlabs.org (Postfix) with ESMTP id 51CF22BF1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 01:28:12 +1100 (EST)
Received: from smtp4.clb.oleane.net (smtp4.clb.oleane.net [213.56.31.20])
	by relay01s.ntr.oleane.net with ESMTP id j05DmKx3007441
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Jan 2005 14:48:31 +0100
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp4.clb.oleane.net with ESMTP id j05DYfa6029455
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Jan 2005 14:34:47 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 5 Jan 2005 14:38:12 +0100
Message-ID: <000001c4f32b$cfe37470$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C4F334.31A7DC70"
Subject: MPC8260 strange virtual addresses returned by kmalloc()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C4F334.31A7DC70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi and Happy New Year to all,

I use a Linux 2.4.25 kernel on a MPC8260 custom board with 128MB of RAM.
PCI is activated and my drivers are loaded as modules.
The RAM is mapped at 0xC0000000 as usual.

On MPC8XX I used kmalloc and iopa to get the physical addresses of the
allocated buffers.
On MPC82XX I used kmalloc and __pa for the same thing and it worked fine
with previous kernel.

But now, when I want to use kmalloc, I get addresses like 0xC9xxxxxx.
The __pa gives me physical addresses 0x09xxxxxx which are out of my physical
RAM.
I tried old iopa function and got some real physical addresses and the
module works.
The virt_to_bus gives me too addresses like  0x09xxxxxx
(ie substract kernel base address 0xC0000000 as usual).

I don't understand why I get virtual addresses which seem to be out of my
memory and why it runs.

More, I have a global variable which is a little buffer. It is also mapped
at a 0xC9xxxxxx address.

Has anyone an idea or a link to a detailed howto ?

Thanks
Bye
Laurent

PS : Linux console informations about memory.

Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (version gcc 3.2.3)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
...
Memory: 127008k available (948k kernel code, 296k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)

------=_NextPart_000_0001_01C4F334.31A7DC70
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE></TITLE>

<META content=3D"MSHTML 6.00.2800.1226" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>Hi and Happy New Year to all,<BR><BR>I =
use a Linux=20
2.4.25 kernel on a MPC8260 custom board<SPAN class=3D593241713-05012005> =

with</SPAN> 128MB o<SPAN class=3D593241713-05012005>f</SPAN> RAM<SPAN=20
class=3D593241713-05012005>.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D593241713-05012005>PCI is =
activated and=20
my drivers are loaded as modules.</SPAN></FONT></DIV><FONT size=3D+0>
<DIV><FONT face=3DArial size=3D2>The&nbsp;RAM is mapped =
at&nbsp;0xC0000000 as usual.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>On MPC8XX I used kmalloc and&nbsp;iopa =
to get the=20
ph<SPAN class=3D593241713-05012005>y</SPAN>sical address<SPAN=20
class=3D593241713-05012005>es</SPAN> of the allocated buffer<SPAN=20
class=3D593241713-05012005>s</SPAN>.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>On MPC82XX I use<SPAN=20
class=3D593241713-05012005>d</SPAN> kmalloc and __pa for the same =
thing<SPAN=20
class=3D593241713-05012005> and it worked fine with previous=20
kernel</SPAN>.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But now<SPAN =
class=3D593241713-05012005>,</SPAN> when=20
I want to use kmalloc, I get addresses =
like&nbsp;0xC9xxxxxx.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The __pa gives me physical addresses =
0x09xxxxxx=20
w<SPAN class=3D593241713-05012005>hich</SPAN> are out of my physical=20
RAM.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I tried&nbsp;old iopa function and got =
some real=20
physical addresses and the module works.</FONT></DIV>
<DIV></FONT><FONT face=3DArial size=3D2>The virt_to_bus&nbsp;gives me =
too addresses=20
like&nbsp;</FONT>&nbsp;<FONT face=3DArial size=3D2>0x09xxxxxx<SPAN=20
class=3D593241713-05012005> </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D593241713-05012005>(ie =
substract kernel=20
base address 0xC0000000 as usual)</SPAN>.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial size=3D2>I =
don't understand=20
why I get virtual addresses which seem to be out of my memory and why it =

runs.</FONT></SPAN></DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial size=3D2>More, =
I have a=20
global variable which is a little buffer. It is also mapped at a =
0xC9xxxxxx=20
address.</FONT></SPAN></DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial size=3D2>Has =
anyone&nbsp;an=20
idea or a link to a detailed howto ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2>Thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2>Bye</FONT></SPAN></DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2>Laurent</FONT></SPAN></DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D593241713-05012005><FONT face=3DArial size=3D2>PS : =
Linux console=20
informations about memory.</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>Memory BAT mapping: BAT2=3D128Mb, =
BAT3=3D0Mb, residual:=20
0Mb<BR>Linux version 2.4.25 (version gcc 3.2.3) </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>On node 0 totalpages: 32768<BR>zone(0): =
32768=20
pages.<BR>zone(1): 0 pages.<BR>zone(2): 0 pages.<BR>...<BR>Memory: =
127008k=20
available (948k kernel code, 296k data, 60k init, 0k highmem)<BR>Dentry =
cache=20
hash table entries: 16384 (order: 5, 131072 bytes)<BR>Inode cache hash =
table=20
entries: 8192 (order: 4, 65536 bytes)<BR>Mount cache hash table entries: =
512=20
(order: 0, 4096 bytes)<BR>Buffer cache hash table entries: 8192 (order: =
3, 32768=20
bytes)<BR>Page-cache hash table entries: 32768 (order: 5, 131072=20
bytes)</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0001_01C4F334.31A7DC70--
