Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 80E67DDE03
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 15:58:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84069.70B415EE"
Subject: RE: Device Tree updates for xilinx.
Date: Sun, 16 Dec 2007 20:58:18 -0800
References: <20071204012811.AD70CEF004D@mail134-dub.bigfish.com>
	<20071213233945.E8FFAA6007C@mail180-sin.bigfish.com>
	<20071216070404.GK21311@localhost.localdomain>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Message-Id: <20071217045726.DD1881298046@mail127-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Michal Simek <simekm2@fel.cvut.cz>,
	git <git@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C84069.70B415EE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Since there don't seem to be any examples of this in the tree: do you =
have a format preference?  For the rest of the compatible lists, I'm =
using something like: xlnx,ipname-version.  So for the microblaze, I'd =
prefer something like:

xlnx,microblaze-6.00.b

For the powerpc, either ibm,ppc405 or ibm.ppc-405 would seem to be more =
in character than PowerPC,405.

Steve

-----Original Message-----
From: David Gibson [mailto:david@gibson.dropbear.id.au]
Sent: Sat 12/15/2007 11:04 PM
To: Stephen Neuendorffer
Cc: Grant Likely; Michal Simek; John Williams; linuxppc-dev@ozlabs.org; =
git
Subject: Re: Device Tree updates for xilinx.
=20
On Thu, Dec 13, 2007 at 03:41:16PM -0800, Stephen Neuendorffer wrote:

>=20
> For reference, below is the device tree for a Virtex2Pro design.  =
Except
> for the changes noted above, this is entirely automatically generated.
>=20
> Steve
>=20
> / {
> 	mem_size_cells: #address-cells =3D <1>;
> 	#size-cells =3D <1>;
> 	compatible =3D "xlnx,virtex";
> 	model =3D "testing";
> 	DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
> 		device_type =3D "memory";
> 		reg =3D < 0 memsize:10000000 >;
> 	} ;
> 	chosen {
> 		bootargs =3D "root=3D/dev/nfs
> nfsroot=3D172.19.221.221:/exports/xup/ydl41 ip=3Ddhcp =
console=3DttyUL0";
> 	} ;
> 	cpus {
> 		#address-cells =3D <1>;
> 		#cpus =3D <1>;
> 		#size-cells =3D <0>;
> 		PowerPC,405@0 {

I'm trying to encourage people to move to naming cpu nodes simply
"cpu@XX", with the type of core in "compatible" instead - in keeping
with the generic names convention used elsewhere.  I think this will
make your generator simpler, too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ =
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson



------_=_NextPart_001_01C84069.70B415EE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Device Tree updates for xilinx.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Since there don't seem to be any examples of this in =
the tree: do you have a format preference?&nbsp; For the rest of the =
compatible lists, I'm using something like: xlnx,ipname-version.&nbsp; =
So for the microblaze, I'd prefer something like:<BR>
<BR>
xlnx,microblaze-6.00.b<BR>
<BR>
For the powerpc, either ibm,ppc405 or ibm.ppc-405 would seem to be more =
in character than PowerPC,405.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: David Gibson [<A =
HREF=3D"mailto:david@gibson.dropbear.id.au">mailto:david@gibson.dropbear.=
id.au</A>]<BR>
Sent: Sat 12/15/2007 11:04 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: Grant Likely; Michal Simek; John Williams; linuxppc-dev@ozlabs.org; =
git<BR>
Subject: Re: Device Tree updates for xilinx.<BR>
<BR>
On Thu, Dec 13, 2007 at 03:41:16PM -0800, Stephen Neuendorffer =
wrote:<BR>
<BR>
&gt;<BR>
&gt; For reference, below is the device tree for a Virtex2Pro =
design.&nbsp; Except<BR>
&gt; for the changes noted above, this is entirely automatically =
generated.<BR>
&gt;<BR>
&gt; Steve<BR>
&gt;<BR>
&gt; / {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_size_cells: #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,virtex&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model =3D &quot;testing&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;memory&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 0 =
memsize:10000000 &gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chosen {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootargs =3D =
&quot;root=3D/dev/nfs<BR>
&gt; nfsroot=3D172.19.221.221:/exports/xup/ydl41 ip=3Ddhcp =
console=3DttyUL0&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpus {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #cpus =3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PowerPC,405@0 {<BR>
<BR>
I'm trying to encourage people to move to naming cpu nodes simply<BR>
&quot;cpu@XX&quot;, with the type of core in &quot;compatible&quot; =
instead - in keeping<BR>
with the generic names convention used elsewhere.&nbsp; I think this =
will<BR>
make your generator simpler, too.<BR>
<BR>
--<BR>
David Gibson&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | I'll have my music baroque, =
and my code<BR>
david AT gibson.dropbear.id.au&nbsp; | minimalist, thank you.&nbsp; NOT =
_the_ _other_<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | _way_ _around_!<BR>
<A =
HREF=3D"http://www.ozlabs.org/~dgibson">http://www.ozlabs.org/~dgibson</A=
><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C84069.70B415EE--
