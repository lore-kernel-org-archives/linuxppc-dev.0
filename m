Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6425D2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 17:00:36 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
Date: Thu, 2 May 2013 07:00:28 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C4D46D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
 <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
 <1366909096.30341.3@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C4C76D@039-SN1MPN1-002.039d.mgd.msft.net>
 <1367267384.32182.14@snotra>
In-Reply-To: <1367267384.32182.14@snotra>
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
> Sent: Tuesday, April 30, 2013 4:30 AM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; Segher Boessenkool; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org
> Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to
> fix PCIe erratum on mpc85xx
>=20
> On 04/26/2013 09:26:26 PM, Jia Hongtao-B38951 wrote:
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, April 26, 2013 12:58 AM
> > > To: Segher Boessenkool
> > > Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> > > galak@kernel.crashing.org; Wood Scott-B07421
> > > Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler
> > to
> > > fix PCIe erratum on mpc85xx
> > >
> > > On 04/25/2013 10:31:51 AM, Segher Boessenkool wrote:
> > > >> * Remove A variant of load instruction emulation
> > > >
> > > > Why is this?  You handle all other simple load insns, there is
> > nothing
> > > > special about LHA.  (I reviewed the V4 email thread, no reason
> > for the
> > > > chance is given there).
> > >
> > > The LHA implementation in V5 was incorrect (didn't sign-extend).
> > >
> > > -Scott
> >
> > In former email you doubt whether we need A variant or not.
> > Any particular reason for that?
> > If not should I emulate all the A ARX AU AUX and AX variant?
>=20
> I was just noting that the variants you left out from the earlier
> revisions (e.g. BRX) were much more likely to be used for I/O than some
> of the ones you included (e.g. "A").  Implementing all the normal
> load/store instructions would be better, if they're done correctly.
>=20
> -Scott

All right.
I have submitted a new version and please have a review.
http://patchwork.ozlabs.org/patch/240238/
http://patchwork.ozlabs.org/patch/240239/

Thanks.
-Hongtao
