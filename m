Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E8709DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Mar 2008 15:31:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C888B0.ED9B731B"
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
Date: Mon, 17 Mar 2008 21:30:23 -0700
References: <16089631.post@talk.nabble.com><20080317155805.1FFB6538064@mail141-sin.bigfish.com>
	<16112415.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Qin Lin" <linkinge@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080318043128.DDDA0ED005E@mail85-dub.bigfish.com>
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

------_=_NextPart_001_01C888B0.ED9B731B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Yes that should work...

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Qin Lin
Sent: Mon 3/17/2008 7:17 PM
To: linuxppc-embedded@ozlabs.org
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
=20

HI Steve:

when i design the system ,i chose opb_emac_1.04a ,No DMA, Use interrupt =
?
Is it the correct setting for the current driver?

Thanks=20



Stephen Neuendorffer wrote:
>=20
>=20
> It should...  (I use it regularly on the xup board)
> Did you remember to connect the interrupt line in your design?
>=20
> Steve
>=20
>> -----Original Message-----
>> From: =
linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
>> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Qin Lin
>> Sent: Monday, March 17, 2008 12:36 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
>>=20
>>=20
>> HI all,
>>=20
>> Is anyone have the opb_emac (no DMA) work with the kernel
> linux-2.6-xlnx
>> from git.xilinx.com.
>> the message seams that it does work ,but the command ping return
> nothing!
>>=20
>> Could you kindly suggest me what to do?
>>=20
>> ps:
>> the kernel booting message
>> [    0.258674] net_namespace: 64 bytes
>> [    0.269780] NET: Registered protocol family 16
>> [    0.290415] Registering device xilinx_emac:0
>> [    0.381687] NET: Registered protocol family 2
>> [    0.392324] IP route cache hash table entries: 2048 (order: 1, =
8192
>> bytes)
>> [    0.399556] TCP established hash table entries: 8192 (order: 4,
> 65536
>> bytes)
>> [    0.403403] TCP bind hash table entries: 8192 (order: 3, 32768
> bytes)
>> [    0.405409] TCP: Hash tables configured (established 8192 bind
> 8192)
>> [    0.405489] TCP reno registered
>> [    0.412758] sysctl table check failed: /kernel/l2cr .1.31 Missing
>> strategy
>> [    0.413189] Call Trace:
>> [    0.413244] [cf41feb0] [c0008178] show_stack+0x48/0x184
> (unreliable)
>> [    0.413467] [cf41fed0] [c00303c8] set_fail+0x50/0x68
>> [    0.413640] [cf41fef0] [c0030b54] sysctl_check_table+0x64c/0x698
>> [    0.413724] [cf41ff20] [c0030b68] sysctl_check_table+0x660/0x698
>> [    0.413802] [cf41ff50] [c001e810] register_sysctl_table+0x64/0xb4
>> [    0.414141] [cf41ff70] [c01e4b1c]
> register_ppc_htab_sysctl+0x18/0x2c
>> [    0.414311] [cf41ff80] [c01de1e4] kernel_init+0xc8/0x284
>> [    0.414384] [cf41fff0] [c0004ab8] kernel_thread+0x44/0x60
>>=20
>> [    1.116395] xilinx_emac xilinx_emac.0: MAC address is now  2: 0: =
0:
> 0: 0:
>> 0
>> [    1.123790] XEmac: using fifo mode.
>> [    1.128188] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev.
>> 0x78e2.
>> [    1.135715] eth0: Dropping NETIF_F_SG since no checksum feature.
>> [    1.151038] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to
> 0xD0020000,
>> irq=3D2
>> [    1.158713] eth0: XEmac id 1.4a, block id 128, type 1
>> [    1.194661] TCP cubic registered
>> [    1.198647] NET: Registered protocol family 1
>> [    1.203728] NET: Registered protocol family 17
>>=20
>>=20
>> #ping 192.168.26.1 &
>> # ifconfig eth0
>> eth0      Link encap:Ethernet  HWaddr 02:00:00:00:00:00
>>           inet addr:192.168.26.127  Bcast:192.168.26.255
> Mask:255.255.255.0
>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:0 (0.0 B)  TX bytes:672 (672.0 B)
>>           Interrupt:2 Memory:40c00000-40c0ffff
>>=20
>> Regards
>>=20
>> Qin Lin
>> --
>> View this message in context:
> =
http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-
>> xlnx-tp16089631p16089631.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>=20
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: =
http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-xl=
nx-tp16089631p16112415.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



------_=_NextPart_001_01C888B0.ED9B731B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Yes that should work...<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Qin Lin<BR>
Sent: Mon 3/17/2008 7:17 PM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx<BR>
<BR>
<BR>
HI Steve:<BR>
<BR>
when i design the system ,i chose opb_emac_1.04a ,No DMA, Use interrupt =
?<BR>
Is it the correct setting for the current driver?<BR>
<BR>
Thanks<BR>
<BR>
<BR>
<BR>
Stephen Neuendorffer wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt; It should...&nbsp; (I use it regularly on the xup board)<BR>
&gt; Did you remember to connect the interrupt line in your design?<BR>
&gt;<BR>
&gt; Steve<BR>
&gt;<BR>
&gt;&gt; -----Original Message-----<BR>
&gt;&gt; From: =
linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org<BR>
&gt; [<A =
HREF=3D"mailto:linuxppc-embedded-">mailto:linuxppc-embedded-</A><BR>
&gt;&gt; bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of =
Qin Lin<BR>
&gt;&gt; Sent: Monday, March 17, 2008 12:36 AM<BR>
&gt;&gt; To: linuxppc-embedded@ozlabs.org<BR>
&gt;&gt; Subject: XUPV2P board opb_emac cannot work with =
linux-2.6-xlnx<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; HI all,<BR>
&gt;&gt;<BR>
&gt;&gt; Is anyone have the opb_emac (no DMA) work with the kernel<BR>
&gt; linux-2.6-xlnx<BR>
&gt;&gt; from git.xilinx.com.<BR>
&gt;&gt; the message seams that it does work ,but the command ping =
return<BR>
&gt; nothing!<BR>
&gt;&gt;<BR>
&gt;&gt; Could you kindly suggest me what to do?<BR>
&gt;&gt;<BR>
&gt;&gt; ps:<BR>
&gt;&gt; the kernel booting message<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.258674] net_namespace: 64 bytes<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.269780] NET: Registered protocol family =
16<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.290415] Registering device =
xilinx_emac:0<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.381687] NET: Registered protocol family =
2<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.392324] IP route cache hash table =
entries: 2048 (order: 1, 8192<BR>
&gt;&gt; bytes)<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.399556] TCP established hash table =
entries: 8192 (order: 4,<BR>
&gt; 65536<BR>
&gt;&gt; bytes)<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.403403] TCP bind hash table entries: 8192 =
(order: 3, 32768<BR>
&gt; bytes)<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.405409] TCP: Hash tables configured =
(established 8192 bind<BR>
&gt; 8192)<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.405489] TCP reno registered<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.412758] sysctl table check failed: =
/kernel/l2cr .1.31 Missing<BR>
&gt;&gt; strategy<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.413189] Call Trace:<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.413244] [cf41feb0] [c0008178] =
show_stack+0x48/0x184<BR>
&gt; (unreliable)<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.413467] [cf41fed0] [c00303c8] =
set_fail+0x50/0x68<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.413640] [cf41fef0] [c0030b54] =
sysctl_check_table+0x64c/0x698<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.413724] [cf41ff20] [c0030b68] =
sysctl_check_table+0x660/0x698<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.413802] [cf41ff50] [c001e810] =
register_sysctl_table+0x64/0xb4<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.414141] [cf41ff70] [c01e4b1c]<BR>
&gt; register_ppc_htab_sysctl+0x18/0x2c<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.414311] [cf41ff80] [c01de1e4] =
kernel_init+0xc8/0x284<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 0.414384] [cf41fff0] [c0004ab8] =
kernel_thread+0x44/0x60<BR>
&gt;&gt;<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.116395] xilinx_emac xilinx_emac.0: MAC =
address is now&nbsp; 2: 0: 0:<BR>
&gt; 0: 0:<BR>
&gt;&gt; 0<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.123790] XEmac: using fifo mode.<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.128188] XEmac: Detected PHY at address 0, =
ManufID 0x0013, Rev.<BR>
&gt;&gt; 0x78e2.<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.135715] eth0: Dropping NETIF_F_SG since =
no checksum feature.<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.151038] eth0: Xilinx 10/100 EMAC at =
0x40C00000 mapped to<BR>
&gt; 0xD0020000,<BR>
&gt;&gt; irq=3D2<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.158713] eth0: XEmac id 1.4a, block id =
128, type 1<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.194661] TCP cubic registered<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.198647] NET: Registered protocol family =
1<BR>
&gt;&gt; [&nbsp;&nbsp;&nbsp; 1.203728] NET: Registered protocol family =
17<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; #ping 192.168.26.1 &amp;<BR>
&gt;&gt; # ifconfig eth0<BR>
&gt;&gt; eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; =
HWaddr 02:00:00:00:00:00<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
inet addr:192.168.26.127&nbsp; Bcast:192.168.26.255<BR>
&gt; Mask:255.255.255.0<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP =
BROADCAST RUNNING&nbsp; MTU:1500&nbsp; Metric:1<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX =
packets:0 errors:0 dropped:0 overruns:0 frame:0<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:16 errors:0 dropped:0 overruns:0 carrier:0<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0 txqueuelen:1000<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX =
bytes:0 (0.0 B)&nbsp; TX bytes:672 (672.0 B)<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Interrupt:2 Memory:40c00000-40c0ffff<BR>
&gt;&gt;<BR>
&gt;&gt; Regards<BR>
&gt;&gt;<BR>
&gt;&gt; Qin Lin<BR>
&gt;&gt; --<BR>
&gt;&gt; View this message in context:<BR>
&gt; <A =
HREF=3D"http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linu=
x-2.6-">http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linu=
x-2.6-</A><BR>
&gt;&gt; xlnx-tp16089631p16089631.html<BR>
&gt;&gt; Sent from the linuxppc-embedded mailing list archive at =
Nabble.com.<BR>
&gt;&gt;<BR>
&gt;&gt; _______________________________________________<BR>
&gt;&gt; Linuxppc-embedded mailing list<BR>
&gt;&gt; Linuxppc-embedded@ozlabs.org<BR>
&gt;&gt; <A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
&gt;<BR>
&gt;<BR>
&gt; _______________________________________________<BR>
&gt; Linuxppc-embedded mailing list<BR>
&gt; Linuxppc-embedded@ozlabs.org<BR>
&gt; <A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
&gt;<BR>
&gt;<BR>
<BR>
--<BR>
View this message in context: <A =
HREF=3D"http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linu=
x-2.6-xlnx-tp16089631p16112415.html">http://www.nabble.com/XUPV2P-board-o=
pb_emac-cannot-work-with-linux-2.6-xlnx-tp16089631p16112415.html</A><BR>
Sent from the linuxppc-embedded mailing list archive at Nabble.com.<BR>
<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C888B0.ED9B731B--
