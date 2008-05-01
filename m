Return-Path: <ron_madrid@hotmail.com>
Received: from bay0-omc1-s40.bay0.hotmail.com (bay0-omc1-s40.bay0.hotmail.com
	[65.54.246.112]) by ozlabs.org (Postfix) with ESMTP id 2ED4CDE02F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 04:29:40 +1000 (EST)
Message-ID: <BAY114-W26E8656DD55138DB5CC3A6F4DB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8444c3a3-76e7-42c1-840c-a7d560bb5880_"
From: Ronald Madrid <ron_madrid@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: NAND command line partiions
Date: Thu, 1 May 2008 11:24:35 -0700
In-Reply-To: <1410.216.70.248.131.1209657620.squirrel@mechanicalanarchy.com>
References: <1410.216.70.248.131.1209657620.squirrel@mechanicalanarchy.com>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_8444c3a3-76e7-42c1-840c-a7d560bb5880_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am using u-boot-1.3.1 in order to boot linux 2.6.25 on a custom MPC8313 b=
ased board.  In past versions of the kernel I was able to pass the NAND par=
tition information to the kernel with this line: root=3D/dev/mtdblock2 root=
fstype=3Djffs2 rw console=3DttyS0,115200 mtdparts=3Dnand0:1M(u-boot),3M(ker=
nel),-(jffs2).  In this latest version the kernel will not mount the partit=
ions because the name that is parsed from the command line (nand0) is diffe=
rent from that of the name of the NAND that comes from ./drivers/mtd/nand/n=
and_ids.c (NAND 256MiB 3,3V 8-bit).

I have tried to change the name of the NAND that is passed in via the comma=
nd line, but u-boot does not seem to like the format of the name that linux=
 compares against.  It doesn't like the ,(comma) in 3,3V.

Does anyone have any suggestions?

Ron Madrid

_________________________________________________________________
Make i'm yours.=A0 Create a custom banner to support your cause.
http://im.live.com/Messenger/IM/Contribute/Default.aspx?source=3DTXT_TAGHM_=
MSN_Make_IM_Yours=

--_8444c3a3-76e7-42c1-840c-a7d560bb5880_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">I am using u-boo=
t-1.3.1 in order to boot linux 2.6.25 on a custom MPC8313 based board.&nbsp=
; In past versions of the kernel I was able to pass the NAND partition info=
rmation to the kernel with this line: root=3D/dev/mtdblock2 rootfstype=3Djf=
fs2 rw console=3DttyS0,115200 mtdparts=3Dnand0:1M(u-boot),3M(kernel),-(jffs=
2).&nbsp; In this latest version the kernel will not mount the partitions b=
ecause the name that is parsed from the command line (nand0) is different f=
rom that of the name of the NAND that comes from ./drivers/mtd/nand/nand_id=
s.c (NAND 256MiB 3,3V 8-bit).<br><br>I have tried to change the name of the=
 NAND that is passed in via the command line, but u-boot does not seem to l=
ike the format of the name that linux compares against.&nbsp; It doesn't li=
ke the ,(comma) in 3,3V.<br><br>Does anyone have any suggestions?<br></div>=
<br>Ron Madrid<br><br /><hr />Make i'm yours. <a href=3D'http://im.live.com=
/Messenger/IM/Contribute/Default.aspx?source=3DTXT_TAGHM_MSN_Make_IM_Yours'=
 target=3D'_new'>Create a custom banner to support your cause.</a></body>
</html>=

--_8444c3a3-76e7-42c1-840c-a7d560bb5880_--
