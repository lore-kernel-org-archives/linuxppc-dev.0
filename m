Return-Path: <gkenaley@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id 9796DDDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 17:20:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75710.FAF9DE9B"
Subject: RE: Gianfar on 8347 sometimes get stuck at startup
Date: Thu, 22 Feb 2007 22:08:04 -0800
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B40223B4A6@monk.echelon.echcorp.com>
From: "Gary Kenaley" <gkenaley@echelon.com>
To: "SIP COP 009" <sipcop009@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C75710.FAF9DE9B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I see a similar problem on the MPC8349E MDS (V1.1 CPUs) in that the =
first ping or tftpboot command often doesn't work in u-boot 1.1.3 or =
(much less often) Wind River Linux kernel 2.6.14. The problem seems =
least severe on a node-to-node gigabit connection and most severe on a =
public 100BT network. I haven't been able to isolate the cause, but the =
severity seems dependent on the driver characteristics of the equipment =
that the 8349 is communicating with. In my case I also see very erratic =
ping times to the NFS server (dependent on how Kudzu configured its =
e1000 driver). The 8349 sometimes slows to a crawl and fills the logs =
with watchdog messages when it mounts NFS partitions and hits the INIT =
phase of boot-up. This is all with out-of-the box software from Motorola =
and Wind River. Maybe we will have better luck with the V3.0 CPUs? I =
wish I could use 2.6.18, but I'm stuck at 2.6.14.
=20
Regards, Gary

________________________________

From: linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org on =
behalf of SIP COP 009
Sent: Thu 2/22/2007 9:14 PM
To: linuxppc-embedded@ozlabs.org
Cc: sipcop009@gmail.com
Subject: Gianfar on 8347 sometimes get stuck at startup


=20
We have the our own MPC8349 based board which has 2 GigEs. It is pretty =
much modelled similar to the 8349ADS EVAL boards, infact we have zero =
changes.
=20
The issue that we are seeing -=20
=20
Sometimes at startup, we have send 2 TX packets to kind-of-kickstart the =
TSEC Tranmission. If we send only packet it does not get to the other =
side. This does not happen always.
=20
The TSEC Registers dont really show any errors nor does the Marvell PHY =
show any errors.
=20
The kernel that we are using is 2.6.11.
=20
Anybody  seen this before or something similar ?=20
=20
Any pointers will be appreciated. We cannot move to any other kernel =
verision right now.
=20
Thanks!
ashutosh
=20

------_=_NextPart_001_01C75710.FAF9DE9B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">=0A=
<HTML dir=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" =
CONTENT=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText97954 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I see a =
similar problem on =0A=
the MPC8349E MDS (V1.1&nbsp;CPUs)&nbsp;in that the first ping or =
tftpboot =0A=
command often doesn't work in u-boot 1.1.3 or (much less often) Wind =
River Linux =0A=
kernel 2.6.14. The problem seems least severe on a node-to-node gigabit =0A=
connection and most severe on a public 100BT network. I haven't been =
able to =0A=
isolate the cause, but&nbsp;the severity&nbsp;seems dependent on the =
driver =0A=
characteristics of the equipment that the 8349 is communicating with. In =
my case =0A=
I also see very erratic ping times to the NFS server (dependent on how =
Kudzu =0A=
configured its e1000 driver). The&nbsp;8349 sometimes slows to a crawl =
and fills =0A=
the logs with watchdog messages when it mounts NFS partitions&nbsp;and =
hits the =0A=
INIT phase of boot-up. This is all with out-of-the box software from =
Motorola =0A=
and Wind River. Maybe we will have better luck with the V3.0 CPUs? I =
wish I =0A=
could use 2.6.18, but I'm stuck at 2.6.14.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Regards, =
Gary</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =0A=
linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org on behalf of =
SIP COP =0A=
009<BR><B>Sent:</B> Thu 2/22/2007 9:14 PM<BR><B>To:</B> =0A=
linuxppc-embedded@ozlabs.org<BR><B>Cc:</B> =0A=
sipcop009@gmail.com<BR><B>Subject:</B> Gianfar on 8347 sometimes get =
stuck at =0A=
startup<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>We have the our own MPC8349 based&nbsp;board which has 2 GigEs. It =
is =0A=
pretty much modelled similar to the 8349ADS EVAL boards, infact we have =
zero =0A=
changes.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>The issue that we are seeing - </DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Sometimes at startup, we have send 2 TX packets to =
kind-of-kickstart the =0A=
TSEC Tranmission. If we send only packet it does not get to the other =
side. This =0A=
does not happen always.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>The TSEC Registers dont really show any errors nor does the Marvell =
PHY =0A=
show any errors.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>The kernel that we are using is 2.6.11.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Anybody &nbsp;seen this before or something similar ? </DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Any pointers will be appreciated. We cannot move to any other =
kernel =0A=
verision right now.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Thanks!</DIV>=0A=
<DIV>ashutosh</DIV>=0A=
<DIV>&nbsp;</DIV></DIV></BODY></HTML>=0A=

------_=_NextPart_001_01C75710.FAF9DE9B--
