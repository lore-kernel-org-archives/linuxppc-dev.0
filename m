Return-Path: <harrytaurus2002@yahoo.com.cn>
Received: from web15608.mail.cnb.yahoo.com (web15608.mail.cnb.yahoo.com
	[202.165.102.62]) by ozlabs.org (Postfix) with SMTP id 103F3DDF9E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 20:55:29 +1000 (EST)
Message-ID: <729154.37897.qm@web15608.mail.cnb.yahoo.com>
Date: Tue, 7 Apr 2009 18:48:47 +0800 (CST)
From: Cao Qingtao <harrytaurus2002@yahoo.com.cn>
Subject: How CPC925 HyperTransport Host Interface mapps NMI request?
To: michael@ellerman.id.au
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-194250392-1239101327=:37897"
Cc: qingtao.cao@windriver.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0-194250392-1239101327=:37897
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,
=C2=A0
Thanks for commenting on my CPC925 EDAC driver. I am on vacation this week =
and will=C2=A0integrate your=C2=A0suggestions=C2=A0next week.
=C2=A0
I am also thinking of adding EDAC NMI support for the AMD8131 chip, which i=
s a HyperTransport Tunnel device that hosts two PCI-X bridges. If enabled, =
each PCI-X bridge could generate NMI interrupt request package upstream, wi=
th vector identifier =3D 0.=20
=C2=A0
The CPC925 user mannual,=C2=A0p111,=C2=A0says that "This interrupt vector i=
s used to set a corresponding interrupt latch", does this mean MPIC interru=
pt pin#0 would be latched=C2=A0on receiving=C2=A0NMI request package?
=C2=A0
However, the pin#0=C2=A0has been=C2=A0specified for Internal I2C master int=
errupt, so it would have to share hwirq #0 with NMI interrupt?
=C2=A0
Thanks a lot!
=C2=A0
Best regards,
=C2=A0
Harry=0A=0A=0A      _______________________________________________________=
____ =0A  =E5=A5=BD=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=
=EF=BC=8C=E9=82=AE=E7=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=
=BA=BF=EF=BC=81 =0Ahttp://card.mail.cn.yahoo.com/
--0-194250392-1239101327=:37897
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>Hi Michael,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks for commenting on my CPC925 EDAC driver. I am on vacation this =
week and will&nbsp;integrate your&nbsp;suggestions&nbsp;next week.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am also thinking of adding EDAC NMI support for the AMD8131 chip, wh=
ich is a HyperTransport Tunnel device that hosts two PCI-X bridges. If enab=
led, each PCI-X bridge could generate NMI interrupt request package upstrea=
m, with vector identifier =3D 0. </DIV>
<DIV>&nbsp;</DIV>
<DIV>The CPC925 user mannual,&nbsp;p111,&nbsp;says that "This interrupt vec=
tor is used to set a corresponding interrupt latch", does this mean MPIC in=
terrupt pin#0 would be latched&nbsp;on receiving&nbsp;NMI request package?<=
/DIV>
<DIV>&nbsp;</DIV>
<DIV>However, the pin#0&nbsp;has been&nbsp;specified for Internal I2C maste=
r interrupt, so it would have to share hwirq #0 with NMI interrupt?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks a lot!</DIV>
<DIV>&nbsp;</DIV>
<DIV>Best regards,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Harry</DIV></td></tr></table><br>=0A=0A=0A      <hr size=3D1><a href=
=3D"http://cn.rd.yahoo.com/mail_cn/tagline/card/*http://card.mail.cn.yahoo.=
com/">  =E5=A5=BD=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=EF=
=BC=8C=E9=82=AE=E7=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=BA=
=BF=EF=BC=81</a>
--0-194250392-1239101327=:37897--
