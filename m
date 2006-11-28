Return-Path: <akhilesh@innomedia.soft.net>
Received: from gateway.innomedia.soft.net (mail.innomedia.soft.net
	[164.164.79.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99107679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 18:15:58 +1100 (EST)
Received: from innomedia ([192.168.18.10]) (authenticated bits=0)
	by gateway.innomedia.soft.net (8.12.11/8.12.11) with ESMTP id
	kAS6oXT1009671
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Nov 2006 12:20:33 +0530
Message-ID: <025b01c712b9$1e191b00$0a12a8c0@innomedia>
From: "Akhilesh Soni" <akhilesh@innomedia.soft.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Question regarding Socket Buffers
Date: Tue, 28 Nov 2006 12:17:47 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0258_01C712E7.37496250"
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

------=_NextPart_000_0258_01C712E7.37496250
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I wish to transmit a skb from a kernel module.For this I've created a =
skb and filled all the necessary fields and the called the called =
dev->hard_start_xmit of the underlying driver and this way I'm able to =
transmit sucessfully.

Now here I've to do memcpy the data every time in the skb->data before =
transmitting which increases my overhead If I've to transmit a lot of =
data. Is there any way in which I can give a pointer to my buffer for =
the data part of the packet and the headers I can fill manually.

Assuming that low level driver supports scatter and gather IO and it can =
take non-linear skb. What is the procedure to do so. I suppose there is =
some shared socket info by which can be done.

Please advice if this is feasible and what are the steps that need to be =
done to do so. I only need to avoid the data copy and my headers are =
prepared in advance and there are not much changes in the header part of =
the packet. This packet is an UDP packet.


Thanx in advance.

Regards,
Akhilesh



------=_NextPart_000_0258_01C712E7.37496250
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I wish to transmit a skb from a kernel =
module.For=20
this I've created a skb and filled all the necessary fields and the =
called the=20
called dev-&gt;hard_start_xmit of the underlying driver and this way I'm =
able to=20
transmit sucessfully.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Now here I've to do memcpy the data =
every time in=20
the skb-&gt;data before transmitting which increases my overhead If I've =
to=20
transmit a lot of data. Is there any way in which I can give a pointer =
to my=20
buffer for the data part of the packet and the headers I can fill=20
manually.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Assuming that low level driver supports =
scatter and=20
gather IO and it can take non-linear skb. What is the procedure to do =
so. I=20
suppose there is some shared socket info by which can be =
done.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please advice if this is feasible and =
what are the=20
steps that need to be done to do so. I only need to avoid the data copy =
and my=20
headers are prepared in advance and there are not much changes in the =
header=20
part of the packet. This packet is an UDP packet.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanx in advance.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Akhilesh</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0258_01C712E7.37496250--
