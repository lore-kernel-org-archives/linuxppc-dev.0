Return-Path: <leowang1998@yahoo.com.cn>
Received: from web15305.mail.cnb.yahoo.com (web15305.mail.cnb.yahoo.com
	[203.209.230.35]) by ozlabs.org (Postfix) with SMTP id 00414DDEEB
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 14:30:24 +1100 (EST)
Message-ID: <814615.7180.qm@web15305.mail.cnb.yahoo.com>
Date: Sat, 21 Feb 2009 11:30:21 +0800 (CST)
From: zhong wang <leowang1998@yahoo.com.cn>
Subject: how to fix 405ex SDR0_MFR_ECS
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1653510492-1235187021=:7180"
Reply-To: leowang1998@yahoo.com.cn
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0-1653510492-1235187021=:7180
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hello all
=C2=A0=C2=A0=C2=A0 SDR0_MFR_ECS is defined for 440xx,now want to change it =
for 405ex ,but i donnot known what means in /drivers/net/ibm_newemac/core.c=
 line 2374 to 2385 ? plese help me=20
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leo
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2009:02:21=0A=0A=0A =
     ___________________________________________________________ =0A  =E5=
=A5=BD=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=EF=BC=8C=E9=82=
=AE=E7=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=BA=BF=EF=BC=81=
 =0Ahttp://card.mail.cn.yahoo.com/
--0-1653510492-1235187021=:7180
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>hello all</DIV>
<DIV>&nbsp;&nbsp;&nbsp; SDR0_MFR_ECS is defined for 440xx,now want to chang=
e it for 405ex ,but i donnot known what means in /drivers/net/ibm_newemac/c=
ore.c line 2374 to 2385 ? plese help me </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; leo</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009:02:21</DIV=
></td></tr></table><br>=0A=0A=0A      <hr size=3D1><a href=3D"http://cn.rd.=
yahoo.com/mail_cn/tagline/card/*http://card.mail.cn.yahoo.com/">  =E5=A5=BD=
=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=EF=BC=8C=E9=82=AE=E7=
=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=BA=BF=EF=BC=81</a>
--0-1653510492-1235187021=:7180--
