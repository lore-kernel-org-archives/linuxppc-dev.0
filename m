Return-Path: <dcb314@hotmail.com>
Received: from DUB004-OMC3S33.hotmail.com (dub004-omc3s33.hotmail.com
 [157.55.2.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D5491A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 19:20:48 +1100 (AEDT)
Message-ID: <DUB128-W3951FD832DE1C66D3A7C799CAD0@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
To: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: linux-4.5-rc4/arch/powerpc/boot/treeboot-akebono.c:90: possible bad
 test ?
Date: Tue, 16 Feb 2016 08:15:25 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hello there=2C=0A=
=0A=
[linux-4.5-rc4/arch/powerpc/boot/treeboot-akebono.c:90]: (style) A pointer =
can not be negative so it is either pointless or an error to check if it is=
 not.=0A=
=0A=
Source code is=0A=
=0A=
=A0=A0=A0 emac =3D finddevice("/plb/opb/ethernet")=3B=0A=
=A0=A0=A0 if (emac> 0) {=0A=
=0A=
but=0A=
=0A=
=A0=A0=A0 void *emac=3B=0A=
=0A=
Suggest new code=0A=
=0A=
=A0=A0=A0 emac =3D finddevice("/plb/opb/ethernet")=3B=0A=
=A0=A0=A0 if (emac !=3D 0) {=0A=
=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
 		 	   		  =
