Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc3-s20.blu0.hotmail.com (blu0-omc3-s20.blu0.hotmail.com
	[65.55.116.95]) by ozlabs.org (Postfix) with ESMTP id B533AB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 16:51:34 +1000 (EST)
Message-ID: <BLU124-W2524979DEF83F7225DFC24B4F00@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_21713310-484d-4c88-9dd6-5ae7e0731e76_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <p.ittershagen@googlemail.com>, <cmunoz@sablenetworks.com>
Subject: RE: Loading Linux from already running code..
Date: Tue, 27 Sep 2011 06:51:30 +0000
In-Reply-To: <CAC157GAaqdNVQf9hycEVft3cgpbVWxOwncBSNwfVFBGQugZjpQ@mail.gmail.com>
References: <BLU124-W1648A42F7514E880C9B199B4F20@phx.gbl>,
	<1317058016.1650.50.camel@pug>,
	<CAC157GAaqdNVQf9hycEVft3cgpbVWxOwncBSNwfVFBGQugZjpQ@mail.gmail.com>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_21713310-484d-4c88-9dd6-5ae7e0731e76_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Philipp and Carlos=2C

Thanks for the reply.

When simpleImage.elf is loaded by a debugger=2C the debugger reads the elf =
image header and places various sections of image into right place in the R=
AM. But when I do it from already_running_code=2C I should manually unpack =
the elf and place the sections in the memory=2C then jump to the start addr=
ess=2C Am I right?

Also=2C
Is it possible to load a simpleImage.bin file and jump to the start address=
 using a function pointer=2C Hence I can avoid unpack_elf_image()...? - Wil=
l this work?


Thanks=2C
Sumesh.



> Date: Mon=2C 26 Sep 2011 20:13:24 +0200
> Subject: Re: Loading Linux from already running code..
> From: p.ittershagen@googlemail.com
> To: cmunoz@sablenetworks.com
> CC: linuxppc-dev@lists.ozlabs.org=3B sumeshkkn@hotmail.com
>=20
> On Mon=2C Sep 26=2C 2011 at 7:26 PM=2C Carlos Munoz <cmunoz@sablenetworks=
.com> wrote:
> > You could build a tarball containing the root files system=2C dtb=2C Li=
nux=2C
> > plus a header indicating where the different pieces need to be loaded.
> > Then your initial code loads the different parts at the right memory
> > locations=2C sets up the Linux arguments=2C and jumps to Linux.
>=20
> That is exactly what the firmware-independent simpleImage.initrd.*
> targets already do. The resulting elf file include the dtb and initrd
> as well as a prompt-like boot arg cli.
> I think it will be possible to just place the simpleImage.initrd.*
> into you memory and let the existing code jump to the start adress of
> the elf image. I managed to start a ppc core using JTAG and the
> simpleImage.initrd elf files and I think the procedure is very much
> the same but instead of the JTAG debugger setting the PC to the start
> address=2C your startup code has to do it.
>=20
>=20
> Philipp
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
 		 	   		  =

--_21713310-484d-4c88-9dd6-5ae7e0731e76_
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
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hi Philipp and Carlos=2C<br><br>Thanks for the reply.<br><br>When simpleIma=
ge.elf is loaded by a debugger=2C the debugger reads the elf image header a=
nd places various sections of image into right place in the RAM. But when I=
 do it from already_running_code=2C I should manually unpack the elf and pl=
ace the sections in the memory=2C then jump to the start address=2C Am I ri=
ght?<br><br>Also=2C<br>Is it possible to load a simpleImage.bin file and ju=
mp to the start address using a function pointer=2C Hence I can avoid unpac=
k_elf_image()...? - Will this work?<br><br><br>Thanks=2C<br>Sumesh.<br><br>=
<br><br><div>&gt=3B Date: Mon=2C 26 Sep 2011 20:13:24 +0200<br>&gt=3B Subje=
ct: Re: Loading Linux from already running code..<br>&gt=3B From: p.ittersh=
agen@googlemail.com<br>&gt=3B To: cmunoz@sablenetworks.com<br>&gt=3B CC: li=
nuxppc-dev@lists.ozlabs.org=3B sumeshkkn@hotmail.com<br>&gt=3B <br>&gt=3B O=
n Mon=2C Sep 26=2C 2011 at 7:26 PM=2C Carlos Munoz &lt=3Bcmunoz@sablenetwor=
ks.com&gt=3B wrote:<br>&gt=3B &gt=3B You could build a tarball containing t=
he root files system=2C dtb=2C Linux=2C<br>&gt=3B &gt=3B plus a header indi=
cating where the different pieces need to be loaded.<br>&gt=3B &gt=3B Then =
your initial code loads the different parts at the right memory<br>&gt=3B &=
gt=3B locations=2C sets up the Linux arguments=2C and jumps to Linux.<br>&g=
t=3B <br>&gt=3B That is exactly what the firmware-independent simpleImage.i=
nitrd.*<br>&gt=3B targets already do. The resulting elf file include the dt=
b and initrd<br>&gt=3B as well as a prompt-like boot arg cli.<br>&gt=3B I t=
hink it will be possible to just place the simpleImage.initrd.*<br>&gt=3B i=
nto you memory and let the existing code jump to the start adress of<br>&gt=
=3B the elf image. I managed to start a ppc core using JTAG and the<br>&gt=
=3B simpleImage.initrd elf files and I think the procedure is very much<br>=
&gt=3B the same but instead of the JTAG debugger setting the PC to the star=
t<br>&gt=3B address=2C your startup code has to do it.<br>&gt=3B <br>&gt=3B=
 <br>&gt=3B Philipp<br>&gt=3B _____________________________________________=
__<br>&gt=3B Linuxppc-dev mailing list<br>&gt=3B Linuxppc-dev@lists.ozlabs.=
org<br>&gt=3B https://lists.ozlabs.org/listinfo/linuxppc-dev<br></div> 		 	=
   		  </div></body>
</html>=

--_21713310-484d-4c88-9dd6-5ae7e0731e76_--
