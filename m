Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s14.bay0.hotmail.com (bay0-omc1-s14.bay0.hotmail.com
	[65.54.246.86]) by ozlabs.org (Postfix) with ESMTP id 06E8FDE02F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 08:00:13 +1100 (EST)
Message-ID: <BAY115-W23015408D36E22FAB3FE50B2240@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_59ba9641-f307-4542-88da-e6de9d950200_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: llandre <r&d2@dave-tech.it>
Subject: RE: V4 FX12 and PLB TEMAC: no space for user logic?
Date: Wed, 13 Feb 2008 21:00:11 +0000
In-Reply-To: <47B2B94A.6090600@dave-tech.it>
References: <47B2B94A.6090600@dave-tech.it>
MIME-Version: 1.0
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

--_59ba9641-f307-4542-88da-e6de9d950200_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


llandre,

Our tests show that V4 FX 12 is really a small device. The FPGA was complet=
ely full with these set of modules:

1- CPU core and related circuits, 2- PLB TEMAC , 3- DDR SDRAM Controller , =
4- PLB BRAM IF , 5- Bridges , 6- OPB UART and 7- OPB EMC controller (Used f=
or interfacing to flash chips )

The synthesis tool we used during our tests was : XST
it seems that there are some solutions to have a more optimized implementat=
ion on FX-12, personally i visited one of the members here who claimed that=
 he has two PLB TEMACs enabled on one FX-12 FPGA. I believe that this is no=
t possible. may be if one use better synthesis tools such as Synplify he ma=
y get slightly better results.

any how, in my idea FX-12 is not suitable for serious projects, it is suita=
ble only for beginning phases of a project and the research phase.=20
We are now focusing on ML410, a great board by Xiling, featuring on FX-60 F=
PGA while keeps costs low.

any questions are welcom,
thanks,
Mohammad.


> Date: Wed, 13 Feb 2008 10:32:58 +0100
> From: r&d2@dave-tech.it
> To: mamsadegh@hotmail.com
> CC: linuxppc-embedded@ozlabs.org
> Subject: V4 FX12 and PLB TEMAC: no space for user logic?
>=20
> Hi Mohammad,
>=20
> I've just had a look at the messages you generously posted in the ml=20
> about your experience with linux on V4 FX12 FPGA.
> I'd like to ask your opinion about FX12 practical usability in this=20
> context (gigabit PLB TEMAC/linux).
> In this message
>=20
> http://article.gmane.org/gmane.linux.ports.ppc.embedded/16816
>=20
> you say the device is completely full. If I understand correctly your=20
> system provides just the devices required to run the bandwidth test so=20
> it seems there is no room for user logic (I think you did not even add=20
> the memory controller required to access the NOR Flash containing=20
> bootloader, kernel image and root fs that is clearly mandatory for=20
> standalone product). Is that true? If it is, this limits a lot the=20
> flexibility of this architecture in this configuration. What do you think=
?
>=20
>=20
>=20
> Regards,
> llandre
>=20
> DAVE Electronics System House - R&D Department
> web:   http://www.dave.eu
> email: r&d2@dave-tech.it

_________________________________________________________________


--_59ba9641-f307-4542-88da-e6de9d950200_
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
<body class=3D'hmmessage'>
llandre,<br><br>Our tests show that V4 FX 12 is really a small device. The =
FPGA was completely full with these set of modules:<br><br>1- CPU core and =
related circuits, 2- PLB TEMAC , 3- DDR SDRAM Controller , 4- PLB BRAM IF ,=
 5- Bridges , 6- OPB UART and 7- OPB EMC controller (Used for interfacing t=
o flash chips )<br><br>The synthesis tool we used during our tests was : XS=
T<br>it seems that there are some solutions to have a more optimized implem=
entation on FX-12, personally i visited one of the members here who claimed=
 that he has two PLB TEMACs enabled on one FX-12 FPGA. I believe that this =
is not possible. may be if one use better synthesis tools such as Synplify =
he may get slightly better results.<br><br>any how, in my idea FX-12 is not=
 suitable for serious projects, it is suitable only for beginning phases of=
 a project and the research phase. <br>We are now focusing on ML410, a grea=
t board by Xiling, featuring on FX-60 FPGA while keeps costs low.<br><br>an=
y questions are welcom,<br>thanks,<br>Mohammad.<br><br><br>&gt; Date: Wed, =
13 Feb 2008 10:32:58 +0100<br>&gt; From: r&amp;d2@dave-tech.it<br>&gt; To: =
mamsadegh@hotmail.com<br>&gt; CC: linuxppc-embedded@ozlabs.org<br>&gt; Subj=
ect: V4 FX12 and PLB TEMAC: no space for user logic?<br>&gt; <br>&gt; Hi Mo=
hammad,<br>&gt; <br>&gt; I've just had a look at the messages you generousl=
y posted in the ml <br>&gt; about your experience with linux on V4 FX12 FPG=
A.<br>&gt; I'd like to ask your opinion about FX12 practical usability in t=
his <br>&gt; context (gigabit PLB TEMAC/linux).<br>&gt; In this message<br>=
&gt; <br>&gt; http://article.gmane.org/gmane.linux.ports.ppc.embedded/16816=
<br>&gt; <br>&gt; you say the device is completely full. If I understand co=
rrectly your <br>&gt; system provides just the devices required to run the =
bandwidth test so <br>&gt; it seems there is no room for user logic (I thin=
k you did not even add <br>&gt; the memory controller required to access th=
e NOR Flash containing <br>&gt; bootloader, kernel image and root fs that i=
s clearly mandatory for <br>&gt; standalone product). Is that true? If it i=
s, this limits a lot the <br>&gt; flexibility of this architecture in this =
configuration. What do you think?<br>&gt; <br>&gt; <br>&gt; <br>&gt; Regard=
s,<br>&gt; llandre<br>&gt; <br>&gt; DAVE Electronics System House - R&amp;D=
 Department<br>&gt; web:   http://www.dave.eu<br>&gt; email: r&amp;d2@dave-=
tech.it<br><br /><hr /> <a href=3D'' target=3D'_new'></a></body>
</html>=

--_59ba9641-f307-4542-88da-e6de9d950200_--
