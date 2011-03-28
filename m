Return-Path: <zhj.bmw@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F63FB6FC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Mar 2011 17:44:00 +1100 (EST)
Received: by wwi36 with SMTP id 36so2343751wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Mar 2011 23:43:55 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 28 Mar 2011 14:43:54 +0800
Message-ID: <AANLkTikeCgomu+fytCDd7kryvnvVxW-MNSqThDKk_=i8@mail.gmail.com>
Subject: Linux MCC driver in SS7 mode for MPC8270
From: =?GB2312?B?1cW66b2o?= <zhj.bmw@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e68e8d286f96f9049f854475
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e68e8d286f96f9049f854475
Content-Type: text/plain; charset=ISO-8859-1

Hi All,
        I am trying to develop Linux MCC driver in SS7 mode for MPC8270.
        In the driver,I want to config MCC as SS7 controller,and execute SS7
ROM microcode in the CPM.
        I have taken the 8260 MCC driver in HDLC mode published in the
sourceforge.net as reference and trying to develop the driver for SS7 mode.
        In the SI router,channel 128~159 connect to the 32 slots of
TDMA2,but only use the even channel.
        The driver is loaded sucessfully.The MCC's RINT0 interruption and
RXF interruption generate all the time,but only occur RXB interrupttion several
times.
        How to solve this problem???
        Expecting your help in this regard.

        Thanks & Regards,

--0016e68e8d286f96f9049f854475
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div>Hi All,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I am trying to develop=
 Linux MCC driver in SS7 mode for MPC8270.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In the driver,I want to con=
fig MCC as SS7 controller,and execute SS7 ROM microcode in the CPM.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have taken the 8260 MCC d=
river in HDLC mode published in the <a href=3D"http://sourceforge.net/" tar=
get=3D"_blank">sourceforge.net</a> as reference and trying to develop the d=
river for SS7 mode.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In the SI router,chann=
el 128~159 connect to the 32 slots of TDMA2,but only use the even channel.<=
/div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The driver is loaded sucess=
fully.The MCC&#39;s RINT0 interruption and RXF interruption generate all th=
e time,but only occur RXB interrupttion s<span lang=3D"en"><span title=3D"=
=B5=E3=BB=F7=BF=C9=CF=D4=CA=BE=C6=E4=CB=FB=B7=AD=D2=EB">everal times.</span=
></span></div>

<div><span lang=3D"en"><span title=3D"=B5=E3=BB=F7=BF=C9=CF=D4=CA=BE=C6=E4=
=CB=FB=B7=AD=D2=EB">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; How to solve=
 this problem???</span></span></div>
<div><span lang=3D"en"><span title=3D"=B5=E3=BB=F7=BF=C9=CF=D4=CA=BE=C6=E4=
=CB=FB=B7=AD=D2=EB">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Expecting yo=
ur help in this regard.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T=
hanks &amp; Regards,<br></span></span></div>

--0016e68e8d286f96f9049f854475--
