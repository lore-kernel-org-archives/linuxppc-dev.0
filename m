Return-Path: <B08248@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 89C972C0323
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 07:37:50 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH][v2] powerpc/e6500: Add Power ISA properties for e6500
 cores
Date: Tue, 5 Mar 2013 20:37:42 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503567049@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1362514602-17920-1-git-send-email-stuart.yoder@freescale.com>
 <1362515356.25308.8@snotra>
In-Reply-To: <1362515356.25308.8@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, March 05, 2013 2:29 PM
> To: Yoder Stuart-B08248
> Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Yoder Stuar=
t-B08248
> Subject: Re: [PATCH][v2] powerpc/e6500: Add Power ISA properties for e650=
0 cores
>=20
> On 03/05/2013 02:16:42 PM, Stuart Yoder wrote:
> > From: Stuart Yoder <stuart.yoder@freescale.com>
> >
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > ---
> > -v2
> >    -fix some typos
> >
> >  arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi |   65
> > ++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
> > b/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
> > new file mode 100644
> > index 0000000..6b4d16a
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
> > @@ -0,0 +1,65 @@
> > +/*
> > + * e6500 Power ISA Device Tree Source (include)
> > + *
> > + * Copyright 2013 Freescale Semiconductor Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following
> > conditions are met:
> > + *     * Redistributions of source code must retain the above
> > copyright
> > + *       notice, this list of conditions and the following
> > disclaimer.
> > + *     * Redistributions in binary form must reproduce the above
> > copyright
> > + *       notice, this list of conditions and the following
> > disclaimer in the
> > + *       documentation and/or other materials provided with the
> > distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *       names of its contributors may be used to endorse or promote
> > products
> > + *       derived from this software without specific prior written
> > permission.
> > + *
> > + *
> > + * ALTERNATIVELY, this software may be distributed under the terms
> > of the
> > + * GNU General Public License ("GPL") as published by the Free
> > Software
> > + * Foundation, either version 2 of that License or (at your option)
> > any
> > + * later version.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND
> > ANY
> > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> > IMPLIED
> > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> > PURPOSE ARE
> > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE
> > FOR ANY
> > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > CONSEQUENTIAL DAMAGES
> > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> > OR SERVICES;
> > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> > CAUSED AND
> > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> > LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > USE OF THIS
> > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +
> > +/ {
> > +	cpus {
> > +		power-isa-version =3D "2.06";
> > +		power-isa-b;		// Base
> > +		power-isa-e;		// Embedded
> > +		power-isa-atb;		// Alternate Time Base
> > +		power-isa-cs;		// Cache Specification
> > +		power-isa-ds;		// Decorated Storage
> > +		power-isa-e.ed;		// Embedded.Enhanced Debug
> > +		power-isa-e.pd;		// Embedded.External PID
> > +		power-isa-e.hv;		// Embedded.Hypervisor
> > +		power-isa-e.le;		// Embedded.Little-Endian
> > +		power-isa-e.pm;		// Embedded.Performance Monitor
> > +		power-isa-e.pc;		// Embedded.Processor Control
> > +		power-isa-ecl;		// Embedded Cache Locking
> > +		power-isa-exp;		// External Proxy
> > +		power-isa-fp;		// Floating Point
> > +		power-isa-fp.r;		// Floating Point.Record
> > +		power-isa-mmc;		// Memory Coherence
> > +		power-isa-scpm;		// Store Conditional Page
> > Mobility
> > +		power-isa-wt;		// Wait
> > +		power-isa-64;		// 64-bit
> > +		power-isa-e.pt;		// Embedded.Page Table
> > +		power-isa-e.hv.lrat;	// Embedded.Hypervisor.LRAT
> > +		power-isa-e.em;		// Embedded Multi-Threading
> > +		power-isa-v;		// Vector (AltiVec)
> > +		power-isa-er;		// Enhanced Reservations (Load
> > and Reserve and Store Cond.)
> > +		power-isa-deo;		// Data Cache Extended
> > Operations
>=20
> ER and DEO are FSL EREF categories, not Power ISA categories.

Ok, so not Power ISA strictly speaking, but are architectural
categories.  So should we invent a new convention of fsl-eref-*??

Stuart
