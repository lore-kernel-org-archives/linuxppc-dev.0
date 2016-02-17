Return-Path: <dcb314@hotmail.com>
Received: from DUB004-OMC1S33.hotmail.com (dub004-omc1s33.hotmail.com
 [157.55.0.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C6811A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:39:44 +1100 (AEDT)
Message-ID: <DUB128-W420C9B466D12DF872907619CAE0@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
To: Daniel Axtens <dja@axtens.net>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: linux-4.5-rc4/arch/powerpc/boot/treeboot-akebono.c:90: possible
 bad test ?
Date: Wed, 17 Feb 2016 07:34:20 +0000
In-Reply-To: <87fuwscm9v.fsf@gamma.ozlabs.ibm.com>
References: <DUB128-W3951FD832DE1C66D3A7C799CAD0@phx.gbl>,
 <87fuwscm9v.fsf@gamma.ozlabs.ibm.com>
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

Hello there Daniel=2C=0A=
=0A=
----------------------------------------=0A=
> That looks like a good suggestion: maybe make the test 'if (!emac)'=0A=
> rather than explicitly comparing with zero.=0A=
=0A=
Righto.=0A=
=0A=
> Are you comfortable sending a patch to that effect?=0A=
=0A=
Sorry=2C no. =0A=
=0A=
My email provider can't implement the somewhat strict whitespace=0A=
rules of kernel patches.=0A=
=0A=
Nothing stopping any keen person implementing that patch=2C however =3B->=
=0A=
=0A=
I checked the rest of the treeboot-akebono.c source code file with=0A=
the static analyser and found nothing wrong. No warnings from=0A=
gcc -Wextra=2C either=2C so after the patch=2C it looks ok to me.=0A=
=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
 		 	   		  =
