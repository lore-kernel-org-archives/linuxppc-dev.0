Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9667CDE019
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 04:22:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [RFC] Xilinx: Add generic configuration option to enable
	all xilinx drivers.
Date: Wed, 19 Mar 2008 10:21:51 -0700
In-Reply-To: <fa686aa40803182205n741c652ci1e1871707c5c3e13@mail.gmail.com>
References: <20080212213120.D51157F806B@mail176-sin.bigfish.com>
	<fa686aa40803182115k241050f0meafccc29b4ef16@mail.gmail.com>
	<20080319043205.12E1F11E0071@mail67-dub.bigfish.com>
	<fa686aa40803182205n741c652ci1e1871707c5c3e13@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080319172154.37C7A14A8089@mail53-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


My feeling is if the drivers should be consistently enabled or not, then
we should enforce that consistency by the structure of the code.

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Tuesday, March 18, 2008 10:06 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; jacmet@sunsite.dk
> Subject: Re: [PATCH] [RFC] Xilinx: Add generic configuration option to
enable all xilinx drivers.
>=20
> On Tue, Mar 18, 2008 at 10:32 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> >
> >
> >
> > Hmm... interesting points.  I guess my feeling was that
XILINX_DRIVERS could
> > be a more broadly configurable option, with some of these ideas in
mind.
> > Currently, it's hidden by default, but we could easily change this
to be
> > visible by default, or selected by a broader number of
architectures.  I
> > tend to think about them as a group: What if x86 *did* support the
> > primitives needed by these drivers, then if the individual drivers
depend on
> > XILINX_DRIVERS, then the modification could be made in one spot.  By
your
> > suggestion, we would have to modify each one independantly.
>=20
> Heh; it's not *that* many drivers and it's just Kconfig stuff which is
> real easy to change.  My preference would be to eliminate
> XILINX_DRIVERS entirely, but I'm not going to fight about it.  :-)
>=20
> Cheers,
> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
