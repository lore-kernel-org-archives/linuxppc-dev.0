Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC3S5.hotmail.com (dub004-omc3s5.hotmail.com
 [157.55.2.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7CBE1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 06:08:41 +1100 (AEDT)
Message-ID: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_f0f1bc6b-6426-4950-a7f3-cb51dc75bc71_"
From: luigi burdo <intermediadc@hotmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "chzigotzky@xenosoft.de" <chzigotzky@xenosoft.de>, Trevor Dickinson
 <contact@a-eon.com>, "matthew@a-eon.com" <matthew@a-eon.com>
Subject: Freescale P5020 cpu will be kvm-pr?
Date: Mon, 29 Feb 2016 20:03:16 +0100
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_f0f1bc6b-6426-4950-a7f3-cb51dc75bc71_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all=2Csorry for this email but i need to ask to  Alexander Graf and Mich=
ael Ellerman if will be possible have kvm and kvm-pr for the Freescale/Nix =
P5020 cpu . We are testing a new desktop machine with this powerpc cpu clas=
sesand right now we see kvm under qemu is working only on emb side=2C this =
because the kernelset the e5500 cpu as a emb and there is no an option for =
build the kernel with book3s.

here are the new machine specs:http://www.vincentperkins.com/AmigaNG/x5000.=
php=20
Thanks for your time and sorry for my English
Luigi BurdoA-eon X5000 Beta Tester=20
 		 	   		  =

--_f0f1bc6b-6426-4950-a7f3-cb51dc75bc71_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi all=2C<div>sorry for this ema=
il but i need to ask to &nbsp=3BAlexander Graf and Michael Ellerman if will=
 be possible have kvm and kvm-pr for&nbsp=3B<span style=3D"font-size: 12pt=
=3B">the Freescale/Nix P5020 cpu .&nbsp=3B</span></div><div><span style=3D"=
font-size: 12pt=3B">We are testing a new desktop machine with this powerpc =
cpu classes</span><div>and right now we see kvm under qemu is working only =
on emb side=2C this because the kernel</div><div>set the e5500 cpu as a emb=
 and there is no an option for build the kernel with book3s.</div><div><br>=
</div><div><br></div><div>here are the new machine specs:</div><div><a href=
=3D"http://www.vincentperkins.com/AmigaNG/x5000.php" target=3D"_blank" styl=
e=3D"font-size: 12pt=3B">http://www.vincentperkins.com/AmigaNG/x5000.php</a=
><span style=3D"font-size: 12pt=3B">&nbsp=3B</span></div><div><br></div><di=
v>Thanks for your time&nbsp=3B</div><div>and sorry for my English</div><div=
><br></div><div>Luigi Burdo</div><div>A-eon X5000 Beta Tester&nbsp=3B</div>=
<div><br></div></div> 		 	   		  </div></body>
</html>=

--_f0f1bc6b-6426-4950-a7f3-cb51dc75bc71_--
