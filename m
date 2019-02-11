Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B1EC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 06:28:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A51B2070C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 06:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TVhIvp8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A51B2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ybSv6vbvzDqNq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 17:28:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ybQn3TljzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 17:26:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="TVhIvp8y"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ybQm6l7Vz9sML; Mon, 11 Feb 2019 17:26:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549866385;
 bh=ub6z0frmV06INkqnCoreqGkhSclKQ5Q3o3bG00BE3Mk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TVhIvp8yZGPy+GCtNb+pDtO1GpmyszHbCWSYVM03crG+g9GXnqOR4qZttHwMf/ISr
 xU2H06sfZQVqUbEE6YKBuiGjgRm8bO6bXZVlxat8kwnKPLdzuThOYPHP5oIR+UfRuA
 4BD3N9/E25A5/bgGU9cel5yrgWwiqDMiNVIbs2SI=
Date: Mon, 11 Feb 2019 13:38:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190211023842.GE7230@umbus.fritz.box>
References: <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
 <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
 <20190208051523.GD2688@umbus.fritz.box>
 <9b556f53-fcfb-2ca3-019e-6ced0ec74c2a@kaod.org>
 <20190208215329.GA9529@blackberry>
 <8c915ed7-5aa5-1276-6598-d5dcd115dd56@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <8c915ed7-5aa5-1276-6598-d5dcd115dd56@kaod.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2019 at 10:41:38AM +0100, C=E9dric Le Goater wrote:
> On 2/8/19 10:53 PM, Paul Mackerras wrote:
> > On Fri, Feb 08, 2019 at 08:58:14AM +0100, C=E9dric Le Goater wrote:
> >> On 2/8/19 6:15 AM, David Gibson wrote:
> >>> On Thu, Feb 07, 2019 at 10:03:15AM +0100, C=E9dric Le Goater wrote:
> >>>> That's the plan I have in mind as suggested by Paul if I understood =
it well.
> >>>> The mechanics are more complex than the patch zapping the PTEs from =
the VMA
> >>>> but it's also safer.
> >>>
> >>> Well, yes, where "safer" means "has the possibility to be correct".
> >>
> >> Well, the only problem with the kernel approach is keeping a pointer o=
n=20
> >> the VMA. If we could call find_vma(), it would be perfectly safe and m=
uch=20
> >> more simpler.
> >=20
> > You seem to be assuming that the kernel can easily work out a single
> > virtual address which will be the only place where a given set of
> > interrupt pages are mapped.  But that is really not possible in the
> > general case, because userspace could have mapped the fd at many
> > different offsets in many different places.
> >=20
> > QEMU doesn't do that; in QEMU, the mmaps are sufficiently limited that
> > it can work out a single virtual address that needs to be changed.
> > The way that QEMU should tell the kernel what that address is and what
> > the mapping should be changed to, is via the existing munmap()/mmap()
> > interface.
>=20
> Yes. We agreed on that. QEMU should handle these mappings somewhere in=20
> VFIO. It's me grumbling, that's all.
>=20
> The discussion has moved to the mmap() interface of the KVM device. The=
=20
> current proposal adds controls on the device creating fds to mmap() the=
=20
> TIMA pages and the ESB pages. David is proposing to use directly the fd=
=20
> of the KVM device to mmap() these pages with a different offset for each=
=20
> set.=20
>=20
> I think that should work pretty well, for passthrough also. The fault=20
> handler should take care of populating the VMA(s) with the appropriate=20
> pages.=20
>=20
> We might support END notification one day, so we should have room for=20
> these pages. And nested might require IRQ space extensions at L1.=20
> something to keep in mind.

I had some more thoughts on this topic.  I think there's been some
confusion because there are more ways of tackling this than I
previously realized:

1) All in kernel

The offset always maps directly to guest irq number and the kernel
somehow binds it either to an IPI or a host irq as necessary.
C=E9dric's original code attempts this, but the mechanism of keeping a
pointer to the VMA can't work.

But.. remapping the irqs should be sufficiently infrequent that it
might be ok to consider simply stepping through all the hosting
process's VMAs to do this.

2) Remapped in qemu (using memory regions)

I _think_ (in hindsight) was C=E9dric's been discussing as the
alternative in more recent posts.

Qemu maps the IPI pages at one place and the passthrough IRQ pages
somewhere else.  The IPIs are mapped into the guest as one memory
region, then any passthrough IRQ pages are mapped over that using
overlapping memory regions.

I don't think this approach will work well, because it could require a
bunch of separate KVM memory slots, which are fairly scarce.

3) Remapped in qemu (using mmap())

This is the approach I (and I think Paul) have been suggested in
contrast to (1).

Qemu maps the IPI pages and maps those into the guest.  When we need
to set up a passthrough IRQ, qemu mmap()s its pages directly over the
IPI pages, and it remains mapped into the guest with the same memory
region / memslot as the IPIs are already using.  If the passthrough
device is removed we have to remap the IPI pages back into place.

4) Dedicated irq numbers

We never re-use regular guest irq numbers for passthrough irqs,
instead we put them somewhere else and keep those mapped to the
passthrough irq pages.

I was favouring this approach, but it does mean there will be a guest
visible difference between kernel_irqchip=3Don and off which isn't
great.


(1) is the most elegant _interface_, but as we've seen it's
problematic to implement.  Looking at the for_all_vmas() approach
could be interesting, but otherwise option (3) might be the most
practical.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxg4DAACgkQbDjKyiDZ
s5J2lQ/7BICtDVjrwLD2u8bEndVcJi+9ZQ/1idQe1/X0btJ4PhO7O1C6gTCzBdOU
YeUUFzX0uWB5B24UTUF6/MSMZPWbEy7wYyz/rPD7wxbvKKKEPAKjHwnI0hYUSQ+w
aFxUg0Tk/Ijg/4Em7kTtlgQwlNX8TujRUqKWbZGoUT1Mtam6X0fYPpOC16JvwphW
OSQ1KhuTS0DSfDevwkzGuqMZr8FqHQm/qpZZ+xAKipuF1BA21WQCEiyEs01vhlL8
OvklBR1zjL9eufmtXZ4gBp3pICjBY5oLw88wXO4IwbtlzaSytpj2Xhn3KaxowN96
JrOVJacBAWaLDRrXJ1j6UuGenq3O7BInNYgy8f+vXL+vtE+iyW9d8zbggC1Rct4F
W7EGzfautpC++wohwq8AP3VgDzdMhBrRqwaZHVoXmfvVYXYxFf5Zbzt6WjhvLrvf
oLXu5nu081lescf36+JtEoGxud/9ppdRy4c3TXr9VEwQgkc5pw2Pra8JDIsrkRWZ
V9u0YIOUpwI1SF/ARaT4X0H6L7QlE/E+7Rt2NteIELOMM2diAYJsa0oOotWpV0nU
tp5uMOcD9MsRskyWjmgj+cLTEJK1Q75xBLyv1Reg3cv8NlYgLYJYQ+GfOqr+2CSN
/GKKTWG39M2z9Qr6faSYMBi/aS0SqjzT4otv3q8fHnL/1a8f408=
=jIg4
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
