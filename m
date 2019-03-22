Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBADC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 03:23:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FA9218FC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 03:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oaFOh9cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FA9218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QTWg2QSBzDqRC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 14:23:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QTTm668fzDqQk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 14:21:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="oaFOh9cq"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44QTTm1g03z9sSN; Fri, 22 Mar 2019 14:21:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1553224908;
 bh=MMcFfSSc5Mohs5/PXTYURg2Ki8hqeRuy+fcNofauepw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oaFOh9cqxjvhX8h4BkfMncdHNnTJ4yAuu7o6jHW1+bCC0HjWI2dqpqqDpIz+/J9mq
 OHuqZQpxOfuj7Mm3FIDBEec6oK2rhMQ5Kl+XPVxVhNo/IboozHAynNZCQpDPiNsbG9
 X+FB5pbryCdFIr1E77JKhPsEXHSYDtka30GjjjrA=
Date: Fri, 22 Mar 2019 14:08:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Message-ID: <20190322030838.GL26431@umbus.fritz.box>
References: <20190315081835.14083-1-aik@ozlabs.ru>
 <20190315081835.14083-3-aik@ozlabs.ru>
 <20190319103619.6534c7df@x1.home>
 <20190320043824.GG31018@umbus.fritz.box>
 <20190320130908.4f837995@x1.home>
 <20190320235600.GB2501@umbus.fritz.box>
 <20190321121934.283cdc67@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <20190321121934.283cdc67@x1.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 12:19:34PM -0600, Alex Williamson wrote:
> On Thu, 21 Mar 2019 10:56:00 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Mar 20, 2019 at 01:09:08PM -0600, Alex Williamson wrote:
> > > On Wed, 20 Mar 2019 15:38:24 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Tue, Mar 19, 2019 at 10:36:19AM -0600, Alex Williamson wrote: =
=20
> > > > > On Fri, 15 Mar 2019 19:18:35 +1100
> > > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > > >    =20
> > > > > > The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe lin=
ks and
> > > > > > (on POWER9) NVLinks. In addition to that, GPUs themselves have =
direct
> > > > > > peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment th=
e POWERNV
> > > > > > platform puts all interconnected GPUs to the same IOMMU group.
> > > > > >=20
> > > > > > However the user may want to pass individual GPUs to the usersp=
ace so
> > > > > > in order to do so we need to put them into separate IOMMU group=
s and
> > > > > > cut off the interconnects.
> > > > > >=20
> > > > > > Thankfully V100 GPUs implement an interface to do by programmin=
g link
> > > > > > disabling mask to BAR0 of a GPU. Once a link is disabled in a G=
PU using
> > > > > > this interface, it cannot be re-enabled until the secondary bus=
 reset is
> > > > > > issued to the GPU.
> > > > > >=20
> > > > > > This defines a reset_done() handler for V100 NVlink2 device whi=
ch
> > > > > > determines what links need to be disabled. This relies on prese=
nce
> > > > > > of the new "ibm,nvlink-peers" device tree property of a GPU tel=
ling which
> > > > > > PCI peers it is connected to (which includes NVLink bridges or =
peer GPUs).
> > > > > >=20
> > > > > > This does not change the existing behaviour and instead adds
> > > > > > a new "isolate_nvlink" kernel parameter to allow such isolation.
> > > > > >=20
> > > > > > The alternative approaches would be:
> > > > > >=20
> > > > > > 1. do this in the system firmware (skiboot) but for that we wou=
ld need
> > > > > > to tell skiboot via an additional OPAL call whether or not we w=
ant this
> > > > > > isolation - skiboot is unaware of IOMMU groups.
> > > > > >=20
> > > > > > 2. do this in the secondary bus reset handler in the POWERNV pl=
atform -
> > > > > > the problem with that is at that point the device is not enable=
d, i.e.
> > > > > > config space is not restored so we need to enable the device (i=
=2Ee. MMIO
> > > > > > bit in CMD register + program valid address to BAR0) in order t=
o disable
> > > > > > links and then perhaps undo all this initialization to bring th=
e device
> > > > > > back to the state where pci_try_reset_function() expects it to =
be.   =20
> > > > >=20
> > > > > The trouble seems to be that this approach only maintains the iso=
lation
> > > > > exposed by the IOMMU group when vfio-pci is the active driver for=
 the
> > > > > device.  IOMMU groups can be used by any driver and the IOMMU cor=
e is
> > > > > incorporating groups in various ways.   =20
> > > >=20
> > > > I don't think that reasoning is quite right.  An IOMMU group doesn't
> > > > necessarily represent devices which *are* isolated, just devices wh=
ich
> > > > *can be* isolated.  There are plenty of instances when we don't need
> > > > to isolate devices in different IOMMU groups: passing both groups to
> > > > the same guest or userspace VFIO driver for example, or indeed when
> > > > both groups are owned by regular host kernel drivers.
> > > >=20
> > > > In at least some of those cases we also don't want to isolate the
> > > > devices when we don't have to, usually for performance reasons. =20
> > >=20
> > > I see IOMMU groups as representing the current isolation of the devic=
e,
> > > not just the possible isolation.  If there are ways to break down that
> > > isolation then ideally the group would be updated to reflect it.  The
> > > ACS disable patches seem to support this, at boot time we can choose =
to
> > > disable ACS at certain points in the topology to favor peer-to-peer
> > > performance over isolation.  This is then reflected in the group
> > > composition, because even though ACS *can be* enabled at the given
> > > isolation points, it's intentionally not with this option.  Whether or
> > > not a given user who owns multiple devices needs that isolation is
> > > really beside the point, the user can choose to connect groups via IO=
MMU
> > > mappings or reconfigure the system to disable ACS and potentially more
> > > direct routing.  The IOMMU groups are still accurately reflecting the
> > > topology and IOMMU based isolation. =20
> >=20
> > Huh, ok, I think we need to straighten this out.  Thinking of iommu
> > groups as possible rather than potential isolation was a conscious
>=20
> possible ~=3D potential

Sorry, I meant "current" not "potential".

> > decision on my part when we were first coming up with them.  The
> > rationale was that that way iommu groups could be static for the
> > lifetime of boot, with more dynamic isolation state layered on top.
> >=20
> > Now, that was based on analogy with PAPR's concept of "Partitionable
> > Endpoints" which are decided by firmware before boot.  However, I
> > think it makes sense in other contexts too: if iommu groups represent
> > current isolation, then we need some other way to advertise possible
> > isolation - otherwise how will the admin (and/or tools) know how it
> > can configure the iommu groups.
> >=20
> > VFIO already has the container, which represents explicitly a "group
> > of groups" that we don't care to isolate from each other.  I don't
> > actually know what other uses of the iommu group infrastructure we
> > have at present and how they treat them.
>=20
> s/that we don't care to isolate/that the user doesn't care to isolate/

Well, true, I guess we still want to isolate them when possible for
additional safety.  But I don't think we should do so when that
isolation has a real performance cost, which it would in the case of
isolating linked GPUs here.

> Though even that is not necessarily accurate, the container represents
> a shared IOMMU context, that context doesn't necessarily include
> mappings between devices, so the device can still be isolated *from
> each other*.

Well, sure, but it's the only mechanism the user has for indicating
that they don't care about isolation between these device.  That might
be because they simply don't care, but it might also be because they
want to use interlinks between those devices for additional
performance.

> > So, if we now have dynamically reconfigurable groups which are a
> > departure from that design, how can we go from here trying to bring
> > things back to consistency.
>=20
> We don't currently have dynamically reconfigurable groups,

Ah, ok.  So what were these other use cases you were describing?  Boot
time options which change how the iommu groups are generated?  Or
something else.

> I think the
> question is how do we introduce dynamically configurable groups within
> the existing design, because whatever intentions were 7.5 years ago is
> rather irrelevant now.

Well, yeah, I guess.

> VFIO groups are mapped directly to IOMMU groups.  IOMMU groups are the
> smallest set of devices which can be considered isolated from other
> sets of devices (not potentially, but as configured).

Hm.. but what actually makes that assumption that this is the case as
configured, rather than just possibly - I'm taking "possible" to mean
possible with this host kernel, not just possible with this hardware.

> VFIO groups are
> the unit of ownership to userspace, therefore a VFIO group must be
> (currently) isolated from other groups.

It must be currently isolated once the VFIO group is instantiated, but
is there actually anything that requires that current isolation before
the iommu group is instantiated as a vfio group.

> The user owns and manages the
> IOMMU context for one or more groups via a container.  A container
> allows efficiency in managing a shared IOVA space between groups.

Yes, and it seems to me an obvious extension to have the container
also permit other efficiencies which aren't compatible with full
isolation.

> > > > > So, if there's a device specific
> > > > > way to configure the isolation reported in the group, which requi=
res
> > > > > some sort of active management against things like secondary bus
> > > > > resets, then I think we need to manage it above the attached endp=
oint
> > > > > driver.   =20
> > > >=20
> > > > The problem is that above the endpoint driver, we don't actually ha=
ve
> > > > enough information about what should be isolated.  For VFIO we want=
 to
> > > > isolate things if they're in different containers, for most regular
> > > > host kernel drivers we don't need to isolate at all (although we mi=
ght
> > > > as well when it doesn't have a cost). =20
> > >=20
> > > This idea that we only want to isolate things if they're in different
> > > containers is bogus, imo.  There are performance reasons why we might
> > > not want things isolated, but there are also address space reasons why
> > > we do.  If there are direct routes between devices, the user needs to
> > > be aware of the IOVA pollution, if we maintain singleton groups, they
> > > don't.  Granted we don't really account for this well in most
> > > userspaces and fumble through it by luck of the address space layout
> > > and lack of devices really attempting peer to peer access. =20
> >=20
> > I don't really follow what you're saying here.
>=20
> If the lack of isolation between devices includes peer-to-peer channels
> then the MMIO of the devices within the group pollutes the IOVA space
> of the container.

Yes, if the permissible IOVA addresses overlap with valid MMIO
addresses.  I don't really see why that's significant, though.  We
already have basically the same situation if there are multiple
devices in a group.  e.g. if you have several devices behind a dumb
PCI-E to PCI bridge, you can't actually prohibit peer-to-peer DMA
between them, and so those devices' MMIOs pollute the IOVA space for
each other, even if they don't for other devices in the container.
There's only so far we can go to prevent the user from shooting
themselves in the foot.

> > > For in-kernel users, we're still theoretically trying to isolate
> > > devices such that they have restricted access to only the resources
> > > they need.  Disabling things like ACS in the topology reduces that
> > > isolation.  AFAICT, most users don't really care about that degree of
> > > isolation, so they run with iommu=3Dpt for native driver performance
> > > while still having the IOMMU available for isolation use cases running
> > > in parallel.  We don't currently have support for on-demand enabling
> > > isolation. =20
> >=20
> > Ok.
> >=20
> > > > The host side nVidia GPGPU
> > > > drivers also won't want to isolate the (host owned) NVLink devices
> > > > from each other, since they'll want to use the fast interconnects =
=20
> > >=20
> > > This falls into the same mixed use case scenario above where we don't
> > > really have a good solution today.  Things like ACS are dynamically
> > > configurable, but we don't expose any interfaces to let drivers or
> > > users change it (aside from setpci, which we don't account for
> > > dynamically).  We assume a simplistic model where if you want IOMMU,
> > > then you must also want the maximum configurable isolation.
> > > Dynamically changing routing is not necessarily the most foolproof
> > > thing either with potentially in-flight transactions and existing DMA
> > > mappings, which is why I've suggested a couple times that perhaps we
> > > could do a software hot-unplug of a sub-hierarchy, muck with isolation
> > > at the remaining node, then re-discover the removed devices. =20
> >=20
> > Ok, so I feel like we need to go fully one way or the other.  Either:
> >=20
> > 1) Groups represent current isolation status, in which case we
> >    deprecate vfio containers in favour of fusing groups beforehand,
> >    and we need some new concept ("isolation atoms"?) to represent what
> >    isolation is possible
>=20
> Nope, containers are owned by users and serve a purpose beyond what
> you're assuming here.  Also, there's 7.5 years of userspace tooling
> broken by this.  I do remember we had discussions about merging groups,
> but what we have now is what we agreed on.

Well, quite - and I thought the reasoning that led to that design was
that groups would be a representation of isolation granularity, not
actual isolation.  That allows them to be static, which as you say,
tools are likely to assume.

> > or
> >=20
> > 2) Groups represent potential isolation, with a higher level construct
> >    representing current isolation.  This could involve making vfio
> >    containers essentially a wrapper around some more generic concept
> >    ("isolation clusters"?) of a group of groups.
>=20
> Have fun.  Containers and groups are exposed to userspace, so you're
> essentially suggesting to throw away all that support, for... I don't
> really know what.

No, I'm not proposing removing containers, just changing them from
being purely VFIO specific to being the VFIO front end to a generic
concept.  Roughly speaking VFIO containers would be to "isolation
clusters" (or whatever) as VFIO groups are to IOMMU groups now.

> Groups are involved in IOMMU context, so dynamically
> changing what a group defines is hard.

Absolutely!  That's why I don't want to, and why my conception of
groups was defined so that they didn't have to.

> Thus my suggestions that mixed
> or dynamic workloads could make use of soft remove and rediscovery for
> sub-hierarchies, unbinding and rebinding drivers such that we have the
> proper expectations of DMA context.   Thanks,

Well, if we have to change groups, then that sounds like the sanest
available way to do it.  But I'm not yet convinced that altering
groups makes sense rather than using a group-of-groups concept on top
of it - which would map to containers in the case of VFIO.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyUUbQACgkQbDjKyiDZ
s5Kv1BAAl7TEFI8Vjfl7hTdH5QpZ0lU3QYs25JZuexiFQBz7YKVFulGyQlJtRgLT
+eYBhTZWj+UaQlaXxI/lqiVWIK0hka8ETU3RqDHwo15UDQkH3qelmDXHLVaZ4GZX
Eyo7WD+5R+FUIN3oYnNt8lh/jMJAuQkuc1wn8pXkP0G7nclGwC5NyO1XMn+EQtBy
BsJQsJMbOOg4kPLibTz05eqfbKFoICxIvwdXxAnXb3OD7XpN8JCOXq+Q/SPbUB8F
JLOf2nPb1Ufg+DnlZq4I7TupxdSf6U0GY28SmTGS6fGkhsLgmHBSedN/EArTWYZK
dbCWqKxyK+eehQOwGx/sKD3oT5iJ8RB6R6zhY+JtrVlQ1PHFM85LF5noFMs6s7pC
BzIN495BHcATs7tK4KuwCwaowKwYAZyw5ioqgxZas7pQcbyDOAYZlypG8NRiUylZ
Swdj0Z6Pl1fai0RuLga3dKTLAIOqNbz9XjJGuGE6a9Q67CtMf7ioSpjkmpLNys1J
VUE7jurCVj8k2lLdMTDLLLD1JXUEZRLsFXgpztmNH6qBzsDDEILGDrmsgZD/wzyy
QHHOSfDShW1DIQ3P2CVMi6pq3dR7Q+M038+5g5CIKdCVoV4ywVffltenqmKAcgqD
Ea+4oHICxjH/vdLf7Stu7ElfZEk1HuJpqWAzRqZBFNrfN9IRJ4M=
=h22c
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
