Return-Path: <steve.belanger@ca.transport.bombardier.com>
Received: from BBTSVLSDC01.TRANSPORT.BOMBARDIER.COM
	(bbtsvlsdc01.transport.bombardier.com [20.133.40.69])
	by ozlabs.org (Postfix) with ESMTP id D3047B6FD1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 00:27:50 +1000 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5200 + BestComm support in QEMU
MIME-Version: 1.0
Message-ID: <OF67848023.5100FBC5-ON852578F5.004F5D2A-852578F5.004F7274@amer.bombardier.com>
From: steve.belanger@ca.transport.bombardier.com
Date: Tue, 23 Aug 2011 10:26:18 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 004F7273852578F5_="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004F7273852578F5_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

I'm Steve, an embedded software developper for Bombardier Transportation=20
Canada. We use the MPC5200 for most of our onboard computers inside train=20
control systems. To enhance our SW engineering process, we would like the=20
emulate the MPC5200 processor using QEMU, an open source software CPU=20
emulator. This software supports the MPC5200 CPU emulation.

However, the network interface is handled with the BestComm DMA engine and =

it seems very difficult to simulate this co-processor with our current=20
knowledge level. In that sense, I would like to know if someone was able=20
to emulate correctly the MPC5200 with the BestComm DMA using QEMU=20
software?

Steve B=E9langer, ing. / Eng.
D=E9veloppeur logiciel embarqu=E9 / Embedded Software Developper
Bombardier Transportation Canada Inc.=20
Train Control and Management System
Saint-Bruno: 450-441-2020 ext.6148

=20
 =20
Please consider the environment before you print / Merci de penser =E0=20
l'environnement avant d'imprimer=20

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=20

This e-mail communication (and any attachment/s) may contain confidential=20
or privileged information and is intended only for the individual(s) or=20
entity named above and to others who have been specifically authorized to=20
receive it. If you are not the intended recipient, please do not read,=20
copy, use or disclose the contents of this communication to others. Please =

notify the sender that you have received this e-mail in error by reply=20
e-mail, and delete the e-mail subsequently. Please note that in order to=20
protect the security of our information systems an AntiSPAM solution is in =

use and will browse through incoming emails.=20
Thank you.=20
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=20


Ce message (ainsi que le(s) fichier(s)), transmis par courriel, peut=20
contenir des renseignements confidentiels ou prot=E9g=E9s et est destin=E9 =
=E0=20
l?usage exclusif du destinataire ci-dessus. Toute autre personne est, par=20
les pr=E9sentes, avis=E9e qu?il est strictement interdit de le diffuser, le=
=20
distribuer ou le reproduire. Si vous l?avez re=E7u par inadvertance,=20
veuillez nous en aviser et d=E9truire ce message. Veuillez prendre note=20
qu'une solution antipollupostage (AntiSPAM) est utilis=E9e afin d'assurer l=
a=20
s=E9curit=E9 de nos syst=E8mes d'information et qu'elle fur=E8tera les cour=
riels=20
entrants.
Merci.=20
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=20



--=_alternative 004F7273852578F5_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi, </font>
<br>
<br><font size=3D2 face=3D"sans-serif">I'm Steve, an embedded software deve=
lopper
for Bombardier Transportation Canada. We use the MPC5200 for most of our
onboard computers inside train control systems. To enhance our SW engineeri=
ng
process, we would like the emulate the MPC5200 processor using QEMU, an
open source software CPU emulator. This software supports the MPC5200 CPU
emulation.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">However, the network interface is ha=
ndled
with the BestComm DMA engine and it seems very difficult to simulate this
co-processor with our current knowledge level. In that sense, I would like
to know if someone was able to emulate correctly the MPC5200 with the BestC=
omm
DMA using QEMU software?</font>
<br><font size=3D2 face=3D"sans-serif"><br>
Steve B=E9langer, ing. / Eng.<br>
D=E9veloppeur logiciel embarqu=E9 / Embedded Software Developper<br>
Bombardier Transportation Canada Inc. <br>
Train Control and Management System<br>
Saint-Bruno: 450-441-2020 ext.6148<br>
<br>
</font><font size=3D2 face=3D"Microsoft Sans Serif"> &nbsp;<br>
 &nbsp;</font><font size=3D1 face=3D"Microsoft Sans Serif"><br>
Please consider the environment before you print / Merci de penser =E0 l'en=
vironnement
avant d'imprimer <br>
<br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
<br>
This e-mail communication (and any attachment/s) may contain confidential
or privileged information and is intended only for the individual(s) or
entity named above and to others who have been specifically authorized
to receive it. If you are not the intended recipient, please do not read,
copy, use or disclose the contents of this communication to others. Please
notify the sender that you have received this e-mail in error by reply
e-mail, and delete the e-mail subsequently. Please note that in order to
protect the security of our information systems an AntiSPAM solution is
in use and will browse through incoming emails. <br>
Thank you. <br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
<br>
<br>
Ce message (ainsi que le(s) fichier(s)), transmis par courriel, peut conten=
ir
des renseignements confidentiels ou prot=E9g=E9s et est destin=E9 =E0 l&#82=
17;usage
exclusif du destinataire ci-dessus. Toute autre personne est, par les pr=E9=
sentes,
avis=E9e qu&#8217;il est strictement interdit de le diffuser, le distribuer=
 ou
le reproduire. Si vous l&#8217;avez re=E7u par inadvertance, veuillez nous =
en
aviser et d=E9truire ce message. Veuillez prendre note qu'une solution anti=
pollupostage
(AntiSPAM) est utilis=E9e afin d'assurer la s=E9curit=E9 de nos syst=E8mes =
d'information
et qu'elle fur=E8tera les courriels entrants.<br>
Merci. <br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
<br>
<br>
</font>
--=_alternative 004F7273852578F5_=--
