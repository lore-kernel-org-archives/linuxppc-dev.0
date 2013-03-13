Return-Path: <B37400@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE4A52C029D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 16:18:30 +1100 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: RE: [PATCH 1/4] Device tree entry for Freescale TDM controller
Date: Wed, 13 Mar 2013 05:17:58 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E06FA8A37@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
 <20130307133421.GA4977@n2100.arm.linux.org.uk>
In-Reply-To: <20130307133421.GA4977@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, March 07, 2013 7:04 PM
> To: Singh Sandeep-B37400
> Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> Aggrwal Poonam-B10812
> Subject: Re: [PATCH 1/4] Device tree entry for Freescale TDM controller
>=20
> I know I'm probably missing something... but... why are these patches
> copied to the ARM list?  They appear to be PowerPC patches.
There was a request from few ARM Linux developers that they were interested
in developing TDM subsystem for ARM and would like to see TDM patches in
ARM mailing list. Just trying to oblige
>=20
> On Thu, Mar 07, 2013 at 04:57:45PM +0530, Sandeep Singh wrote:
> > Added dtsi file for Freescale TDM controller.
> > This controller is available on many Freescale SOCs like MPC8315,
> > P1020, P1010,
> > P1022 and P1024
> > Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
> > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi |   42
> +++++++++++++++++++++++++++
> >  1 files changed, 42 insertions(+), 0 deletions(-)  create mode 100644
> > arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> > b/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> > new file mode 100644
> > index 0000000..e89f637
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> > @@ -0,0 +1,42 @@
> > +/*
> > + * PQ3 TDM device tree stub [ controller @ offset 0x16000 ]
> > + *
> > + * Copyright 2012 Freescale Semiconductor Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> are met:
> > + *     * Redistributions of source code must retain the above
> copyright
> > + *       notice, this list of conditions and the following disclaimer.
> > + *     * Redistributions in binary form must reproduce the above
> copyright
> > + *       notice, this list of conditions and the following disclaimer
> in the
> > + *       documentation and/or other materials provided with the
> distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *       names of its contributors may be used to endorse or promote
> products
> > + *       derived from this software without specific prior written
> permission.
> > + *
> > + *
> > + * ALTERNATIVELY, this software may be distributed under the terms of
> > +the
> > + * GNU General Public License ("GPL") as published by the Free
> > +Software
> > + * Foundation, either version 2 of that License or (at your option)
> > +any
> > + * later version.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND
> > +ANY
> > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> > +IMPLIED
> > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> > +ARE
> > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE
> > +FOR ANY
> > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> > +DAMAGES
> > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> > +SERVICES;
> > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> > +CAUSED AND
> > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> > +OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > +USE OF THIS
> > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +
> > +tdm@16000 {
> > +	compatible =3D "fsl,tdm1.0";
> > +	reg =3D <0x16000 0x200 0x2c000 0x2000>;
> > +	clock-frequency =3D <0>;
> > +	tdm_tx_clk =3D <2048000>;
> > +	interrupts =3D <62 8 0 0>;
> > +	fsl,max-time-slots =3D <128>;
> > +};
> > --
> > 1.7.6.GIT
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
