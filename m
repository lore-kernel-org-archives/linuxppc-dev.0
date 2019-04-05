Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D42C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 00:36:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6585A217D4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 00:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bEJz1y2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6585A217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44b18j6Pw0zDqLx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44b16M5J0bzDqNK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 11:34:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="bEJz1y2Z"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44b16M0xKRz9sPn; Fri,  5 Apr 2019 11:34:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1554424475;
 bh=vR+5NyQJsuklUnvjLRTyubz8jzCS3LgZNBFGgUC6gSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bEJz1y2ZDchXhjy8TZAX7RtH9cIU4VEpNcjNaIXvqPack+v6wnM4Z5/nBMJoiFcRt
 GvR+gKJfg3U4DcMR89tvjHLRanioYdS8M2by0vd1nYc2YYE35bGU5xfGaVxdLasupY
 J5lR42rrLxNpHjBUA33/eW7hNZeyzJAAIIgEV3Us=
Date: Fri, 5 Apr 2019 11:34:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Message-ID: <20190405003429.GD25513@umbus.fritz.box>
References: <20190322171025.64bc328c@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20190322171025.64bc328c@x1.home>
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


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 05:10:25PM -0600, Alex Williamson wrote:
> On Fri, 22 Mar 2019 14:08:38 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Mar 21, 2019 at 12:19:34PM -0600, Alex Williamson wrote:
> > > On Thu, 21 Mar 2019 10:56:00 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Wed, Mar 20, 2019 at 01:09:08PM -0600, Alex Williamson wrote: =
=20
> > > > > On Wed, 20 Mar 2019 15:38:24 +1100
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >    =20
> > > > > > On Tue, Mar 19, 2019 at 10:36:19AM -0600, Alex Williamson wrote=
:   =20
> > > > > > > On Fri, 15 Mar 2019 19:18:35 +1100
> > > > > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > > > > >      =20
> > > > > > > > The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe=
 links and
> > > > > > > > (on POWER9) NVLinks. In addition to that, GPUs themselves h=
ave direct
> > > > > > > > peer to peer NVLinks in groups of 2 to 4 GPUs. At the momen=
t the POWERNV
> > > > > > > > platform puts all interconnected GPUs to the same IOMMU gro=
up.
> > > > > > > >=20
> > > > > > > > However the user may want to pass individual GPUs to the us=
erspace so
> > > > > > > > in order to do so we need to put them into separate IOMMU g=
roups and
> > > > > > > > cut off the interconnects.
> > > > > > > >=20
> > > > > > > > Thankfully V100 GPUs implement an interface to do by progra=
mming link
> > > > > > > > disabling mask to BAR0 of a GPU. Once a link is disabled in=
 a GPU using
> > > > > > > > this interface, it cannot be re-enabled until the secondary=
 bus reset is
> > > > > > > > issued to the GPU.
> > > > > > > >=20
> > > > > > > > This defines a reset_done() handler for V100 NVlink2 device=
 which
> > > > > > > > determines what links need to be disabled. This relies on p=
resence
> > > > > > > > of the new "ibm,nvlink-peers" device tree property of a GPU=
 telling which
> > > > > > > > PCI peers it is connected to (which includes NVLink bridges=
 or peer GPUs).
> > > > > > > >=20
> > > > > > > > This does not change the existing behaviour and instead adds
> > > > > > > > a new "isolate_nvlink" kernel parameter to allow such isola=
tion.
> > > > > > > >=20
> > > > > > > > The alternative approaches would be:
> > > > > > > >=20
> > > > > > > > 1. do this in the system firmware (skiboot) but for that we=
 would need
> > > > > > > > to tell skiboot via an additional OPAL call whether or not =
we want this
> > > > > > > > isolation - skiboot is unaware of IOMMU groups.
> > > > > > > >=20
> > > > > > > > 2. do this in the secondary bus reset handler in the POWERN=
V platform -
> > > > > > > > the problem with that is at that point the device is not en=
abled, i.e.
> > > > > > > > config space is not restored so we need to enable the devic=
e (i.e. MMIO
> > > > > > > > bit in CMD register + program valid address to BAR0) in ord=
er to disable
> > > > > > > > links and then perhaps undo all this initialization to brin=
g the device
> > > > > > > > back to the state where pci_try_reset_function() expects it=
 to be.     =20
> > > > > > >=20
> > > > > > > The trouble seems to be that this approach only maintains the=
 isolation
> > > > > > > exposed by the IOMMU group when vfio-pci is the active driver=
 for the
> > > > > > > device.  IOMMU groups can be used by any driver and the IOMMU=
 core is
> > > > > > > incorporating groups in various ways.     =20
> > > > > >=20
> > > > > > I don't think that reasoning is quite right.  An IOMMU group do=
esn't
> > > > > > necessarily represent devices which *are* isolated, just device=
s which
> > > > > > *can be* isolated.  There are plenty of instances when we don't=
 need
> > > > > > to isolate devices in different IOMMU groups: passing both grou=
ps to
> > > > > > the same guest or userspace VFIO driver for example, or indeed =
when
> > > > > > both groups are owned by regular host kernel drivers.
> > > > > >=20
> > > > > > In at least some of those cases we also don't want to isolate t=
he
> > > > > > devices when we don't have to, usually for performance reasons.=
   =20
> > > > >=20
> > > > > I see IOMMU groups as representing the current isolation of the d=
evice,
> > > > > not just the possible isolation.  If there are ways to break down=
 that
> > > > > isolation then ideally the group would be updated to reflect it. =
 The
> > > > > ACS disable patches seem to support this, at boot time we can cho=
ose to
> > > > > disable ACS at certain points in the topology to favor peer-to-pe=
er
> > > > > performance over isolation.  This is then reflected in the group
> > > > > composition, because even though ACS *can be* enabled at the given
> > > > > isolation points, it's intentionally not with this option.  Wheth=
er or
> > > > > not a given user who owns multiple devices needs that isolation is
> > > > > really beside the point, the user can choose to connect groups vi=
a IOMMU
> > > > > mappings or reconfigure the system to disable ACS and potentially=
 more
> > > > > direct routing.  The IOMMU groups are still accurately reflecting=
 the
> > > > > topology and IOMMU based isolation.   =20
> > > >=20
> > > > Huh, ok, I think we need to straighten this out.  Thinking of iommu
> > > > groups as possible rather than potential isolation was a conscious =
=20
> > >=20
> > > possible ~=3D potential =20
> >=20
> > Sorry, I meant "current" not "potential".
> >=20
> > > > decision on my part when we were first coming up with them.  The
> > > > rationale was that that way iommu groups could be static for the
> > > > lifetime of boot, with more dynamic isolation state layered on top.
> > > >=20
> > > > Now, that was based on analogy with PAPR's concept of "Partitionable
> > > > Endpoints" which are decided by firmware before boot.  However, I
> > > > think it makes sense in other contexts too: if iommu groups represe=
nt
> > > > current isolation, then we need some other way to advertise possible
> > > > isolation - otherwise how will the admin (and/or tools) know how it
> > > > can configure the iommu groups.
> > > >=20
> > > > VFIO already has the container, which represents explicitly a "group
> > > > of groups" that we don't care to isolate from each other.  I don't
> > > > actually know what other uses of the iommu group infrastructure we
> > > > have at present and how they treat them. =20
> > >=20
> > > s/that we don't care to isolate/that the user doesn't care to isolate=
/ =20
> >=20
> > Well, true, I guess we still want to isolate them when possible for
> > additional safety.  But I don't think we should do so when that
> > isolation has a real performance cost, which it would in the case of
> > isolating linked GPUs here.
>=20
> I don't see that we can presume the user's intentions.  This sounds
> like we're putting the kernel into the position of deciding policy.

It's not really a question of intentions.  If two devices are in the
same container, then they are *not* isolated from the user's point of
view.  Maybe they can't get at each other's MMIO, but they can clobber
each other's DMA inputs and outputs, and for many devices that will
include descriptor tables, allowing them to adversely affect each
others' behaviours.

> > > Though even that is not necessarily accurate, the container represents
> > > a shared IOMMU context, that context doesn't necessarily include
> > > mappings between devices, so the device can still be isolated *from
> > > each other*. =20
> >=20
> > Well, sure, but it's the only mechanism the user has for indicating
> > that they don't care about isolation between these device.  That might
> > be because they simply don't care, but it might also be because they
> > want to use interlinks between those devices for additional
> > performance.
>=20
> Is a user really indicating "I don't care about isolation" by placing
> groups within the same container or just taking advantage of a shared
> IOMMU context?  Again, we're presuming a policy decision that's never
> been defined in the API.  It is possible to have both isolation and
> performance, for instance ACS includes a direct translated p2p feature
> that allows translated requests a direct path between devices, at least
> on the PCIe fabric (where supported by hardware).
>=20
> > > > So, if we now have dynamically reconfigurable groups which are a
> > > > departure from that design, how can we go from here trying to bring
> > > > things back to consistency. =20
> > >=20
> > > We don't currently have dynamically reconfigurable groups, =20
> >=20
> > Ah, ok.  So what were these other use cases you were describing?  Boot
> > time options which change how the iommu groups are generated?  Or
> > something else.
>=20
>         pci=3Doption[,option...]  [PCI] various PCI subsystem options.
>=20
>                                 Some options herein operate on a specific=
 device
>                                 or a set of devices (<pci_dev>). These are
>                                 specified in one of the following formats:
>=20
>                                 [<domain>:]<bus>:<dev>.<func>[/<dev>.<fun=
c>]*
>                                 pci:<vendor>:<device>[:<subvendor>:<subde=
vice>]
>=20
>         ...
>                 disable_acs_redir=3D<pci_dev>[; ...]
>                                 Specify one or more PCI devices (in the f=
ormat
>                                 specified above) separated by semicolons.
>                                 Each device specified will have the PCI A=
CS
>                                 redirect capabilities forced off which wi=
ll
>                                 allow P2P traffic between devices through
>                                 bridges without forcing it upstream. Note:
>                                 this removes isolation between devices and
>                                 may put more devices in an IOMMU group.
>=20
> AIUI, GPU and RDMA were primary use cases for this.  As noted, IOMMU
> groups take this into account since it's done at boot time and static,
> we're simply disabling isolation switches that would have otherwise
> been enabled at points in the topology (specifically enabling p2p as
> much as possible), and the IOMMU group grows to match.

Right.  It's better than nothing, but requiring boot time
configuration is a pain.  It'd be nice to have a way of runtime
configuring it.  That will be much nicer to use if we can also runtime
introspect it, which requires some kind of two-level system
distinguishing current from possible isolation.

> The NVLink problem is rather the opposite of this, rather than simply
> disabling isolation for a sub-hierarchy and growing the IOMMU group, we
> need to enable isolation and then actively, and repeatedly maintain
> that configuration as it represents a finer granularity isolation
> promise to the system.  And of course we're trying to manage the
> isolation of an interconnect for which we have no visibility.

Sigh.  Yeah.  That's pretty horrible.

> > > I think the
> > > question is how do we introduce dynamically configurable groups within
> > > the existing design, because whatever intentions were 7.5 years ago is
> > > rather irrelevant now. =20
> >=20
> > Well, yeah, I guess.
> >=20
> > > VFIO groups are mapped directly to IOMMU groups.  IOMMU groups are the
> > > smallest set of devices which can be considered isolated from other
> > > sets of devices (not potentially, but as configured). =20
> >=20
> > Hm.. but what actually makes that assumption that this is the case as
> > configured, rather than just possibly - I'm taking "possible" to mean
> > possible with this host kernel, not just possible with this hardware.
>=20
> The IOMMU driver is ultimately responsible for deciding the isolation,
> but we have shared code that understands the PCI/e topology.  That code
> looks at the actual, current ACS settings to decide the highest point
> in the topology where we might have p2p.

Right, but I was more thinking about the consumers of the information
than the producer.

> > > VFIO groups are
> > > the unit of ownership to userspace, therefore a VFIO group must be
> > > (currently) isolated from other groups. =20
> >=20
> > It must be currently isolated once the VFIO group is instantiated, but
> > is there actually anything that requires that current isolation before
> > the iommu group is instantiated as a vfio group.
>=20
> The iommu-core is incorporating more group-aware support, I believe
> default domains are group based and we might have per group reserved
> ranges, I'm not sure about that.

Hm, ok.

> > > The user owns and manages the
> > > IOMMU context for one or more groups via a container.  A container
> > > allows efficiency in managing a shared IOVA space between groups. =20
> >=20
> > Yes, and it seems to me an obvious extension to have the container
> > also permit other efficiencies which aren't compatible with full
> > isolation.
>=20
> It might be a control point, yes, but I don't see that we can presume
> it.

Well, as above, I think the container already means the devices can't
really be considered isolated, even if they are in the limited sense
of can't touch each others MMIOs.

> If we were to automatically enable redirection within a container,
> we could wreak havoc on the IOVA space for the user.

Granted, am thinking more of the power case where the IOVA and MMIO
address ranges are well separated from each other anyway.  Is there
any way we can set up the PCI address space on x86 to ensure that
regardless of group separation?

> ACS also
> theoretically provides a hardware path to enable this via direct
> translated p2p as well.
>=20
> > > > > > > So, if there's a device specific
> > > > > > > way to configure the isolation reported in the group, which r=
equires
> > > > > > > some sort of active management against things like secondary =
bus
> > > > > > > resets, then I think we need to manage it above the attached =
endpoint
> > > > > > > driver.     =20
> > > > > >=20
> > > > > > The problem is that above the endpoint driver, we don't actuall=
y have
> > > > > > enough information about what should be isolated.  For VFIO we =
want to
> > > > > > isolate things if they're in different containers, for most reg=
ular
> > > > > > host kernel drivers we don't need to isolate at all (although w=
e might
> > > > > > as well when it doesn't have a cost).   =20
> > > > >=20
> > > > > This idea that we only want to isolate things if they're in diffe=
rent
> > > > > containers is bogus, imo.  There are performance reasons why we m=
ight
> > > > > not want things isolated, but there are also address space reason=
s why
> > > > > we do.  If there are direct routes between devices, the user need=
s to
> > > > > be aware of the IOVA pollution, if we maintain singleton groups, =
they
> > > > > don't.  Granted we don't really account for this well in most
> > > > > userspaces and fumble through it by luck of the address space lay=
out
> > > > > and lack of devices really attempting peer to peer access.   =20
> > > >=20
> > > > I don't really follow what you're saying here. =20
> > >=20
> > > If the lack of isolation between devices includes peer-to-peer channe=
ls
> > > then the MMIO of the devices within the group pollutes the IOVA space
> > > of the container. =20
> >=20
> > Yes, if the permissible IOVA addresses overlap with valid MMIO
> > addresses.  I don't really see why that's significant, though.  We
> > already have basically the same situation if there are multiple
> > devices in a group.  e.g. if you have several devices behind a dumb
> > PCI-E to PCI bridge, you can't actually prohibit peer-to-peer DMA
> > between them, and so those devices' MMIOs pollute the IOVA space for
> > each other, even if they don't for other devices in the container.
> > There's only so far we can go to prevent the user from shooting
> > themselves in the foot.
>=20
> So it's therefore OK to intentionally pollute the container IOVA
> space?  I believe we'd like to think that hardware is headed towards
> being more isolation-aware and will evolve to the point where we have
> typically singleton group.  Perhaps we'll also evolve to supporting ACS
> direct translated p2p so that we have both a pristine IOVA space and
> direct routes between devices.  There are current issues with
> non-singleton groups that userspace doesn't handle (see "fumble
> through" comment above), but I'm not willing to say "this is
> userspace's problem anyway, therefore it's ok it make it worse".
>=20
> > > > > For in-kernel users, we're still theoretically trying to isolate
> > > > > devices such that they have restricted access to only the resourc=
es
> > > > > they need.  Disabling things like ACS in the topology reduces that
> > > > > isolation.  AFAICT, most users don't really care about that degre=
e of
> > > > > isolation, so they run with iommu=3Dpt for native driver performa=
nce
> > > > > while still having the IOMMU available for isolation use cases ru=
nning
> > > > > in parallel.  We don't currently have support for on-demand enabl=
ing
> > > > > isolation.   =20
> > > >=20
> > > > Ok.
> > > >  =20
> > > > > > The host side nVidia GPGPU
> > > > > > drivers also won't want to isolate the (host owned) NVLink devi=
ces
> > > > > > from each other, since they'll want to use the fast interconnec=
ts   =20
> > > > >=20
> > > > > This falls into the same mixed use case scenario above where we d=
on't
> > > > > really have a good solution today.  Things like ACS are dynamical=
ly
> > > > > configurable, but we don't expose any interfaces to let drivers or
> > > > > users change it (aside from setpci, which we don't account for
> > > > > dynamically).  We assume a simplistic model where if you want IOM=
MU,
> > > > > then you must also want the maximum configurable isolation.
> > > > > Dynamically changing routing is not necessarily the most foolproof
> > > > > thing either with potentially in-flight transactions and existing=
 DMA
> > > > > mappings, which is why I've suggested a couple times that perhaps=
 we
> > > > > could do a software hot-unplug of a sub-hierarchy, muck with isol=
ation
> > > > > at the remaining node, then re-discover the removed devices.   =
=20
> > > >=20
> > > > Ok, so I feel like we need to go fully one way or the other.  Eithe=
r:
> > > >=20
> > > > 1) Groups represent current isolation status, in which case we
> > > >    deprecate vfio containers in favour of fusing groups beforehand,
> > > >    and we need some new concept ("isolation atoms"?) to represent w=
hat
> > > >    isolation is possible =20
> > >=20
> > > Nope, containers are owned by users and serve a purpose beyond what
> > > you're assuming here.  Also, there's 7.5 years of userspace tooling
> > > broken by this.  I do remember we had discussions about merging group=
s,
> > > but what we have now is what we agreed on. =20
> >=20
> > Well, quite - and I thought the reasoning that led to that design was
> > that groups would be a representation of isolation granularity, not
> > actual isolation.  That allows them to be static, which as you say,
> > tools are likely to assume.
>=20
> What is the value of this idea of potential isolation?  Any device
> might be considered potentially isolated, simply disable all the
> devices around it.

Well, assuming there's a disabling mechanism of suitable granularity.

> So now we have a "potentially isolated" group at
> each device.  What have we accomplished?  How do we build that into a
> user interface?  Who decides where the actual isolation lines are
> drawn?  Not that it didn't happen, but I don't recall this design idea
> and I don't see how it's practical.

The UI I had in mind is that this minimum granularity is what's
advertised to userspace.  Again, this could vary with kernel
capabilities not just hardware capabilities - "theoretically
isolatable, but we haven't implemented that" counts as a single group.

When userspace wants to use some devices, it can choose whether to
grab them individually or to put several of its choice into a
"container" (analgous to a VFIO container, but could become a more
generic concept).  Being in a container means the kernel should
prioritize performance over isolation.  If the devices are widely
separated (e.g. separate PCI domains) that might not mean anything
much (beyond sharing a logical IOMMU AS), but if there's some sort of
fast-path between them, the kernel would enable it.

> > > > or
> > > >=20
> > > > 2) Groups represent potential isolation, with a higher level constr=
uct
> > > >    representing current isolation.  This could involve making vfio
> > > >    containers essentially a wrapper around some more generic concept
> > > >    ("isolation clusters"?) of a group of groups. =20
> > >=20
> > > Have fun.  Containers and groups are exposed to userspace, so you're
> > > essentially suggesting to throw away all that support, for... I don't
> > > really know what. =20
> >=20
> > No, I'm not proposing removing containers, just changing them from
> > being purely VFIO specific to being the VFIO front end to a generic
> > concept.  Roughly speaking VFIO containers would be to "isolation
> > clusters" (or whatever) as VFIO groups are to IOMMU groups now.
>=20
> Renaming everything doesn't help.  AFAIK, there's nothing in vfio that
> prevents groups from being dynamic (changing them while in use might be
> unkind though), but they must be isolated from other groups.  We can't
> move the line where we have isolation to anything above the group.
> Groups are currently not dynamic because "it's hard" (tm), but
> obviously it can be done with device removal and rediscovery.
> =20
> > > Groups are involved in IOMMU context, so dynamically
> > > changing what a group defines is hard. =20
> >=20
> > Absolutely!  That's why I don't want to, and why my conception of
> > groups was defined so that they didn't have to.
>=20
> As above, groups are the unit of userspace ownership and therefore must
> be isolated.
>=20
> > > Thus my suggestions that mixed
> > > or dynamic workloads could make use of soft remove and rediscovery for
> > > sub-hierarchies, unbinding and rebinding drivers such that we have the
> > > proper expectations of DMA context.   Thanks, =20
> >=20
> > Well, if we have to change groups, then that sounds like the sanest
> > available way to do it.  But I'm not yet convinced that altering
> > groups makes sense rather than using a group-of-groups concept on top
> > of it - which would map to containers in the case of VFIO.
>=20
> Groups must be isolated in the vfio API.  What happens underneath a
> group might be fungible, but the exposed group must be isolated.

Still not seeing what makes that an immutable law.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlymopMACgkQbDjKyiDZ
s5IXXw//W2mbD98GLWvtwvSQM31MrkuD8FLlTOFeDVt4M9H1jKUMs/9crjYKAjP/
nVNqzMkQyhG8xmd9oIEONtQBj5ve7CF+260F5iR7nJPa32UI4IkEU6DtJD73KipF
hwjBnfYZUyx6K43R7bynrvhCDs0vTIj0GPy5jG7I1OqQicB4+1lXRfoL2L3LD59x
YTDVDZWHTLAX1ExlY3WGNjjt7pfidKNeEl8eHBfSFM2HyVQdbUzpVAf4Y6zEDiJa
/0UOiwyKlyVWpdrOBPDxd7UnfNgARYkf4T6cMEbuyRaWo4Oq/7JDUIb15SUr/LpX
ztVIk7HPgk1a+kvRU7TigO84DXGCUiQTg0jVnfVp2l+n99EO4070Hc9z6C42A8XF
gIfs3Dd1wWz4NXOZju5PNSwesxv4QkxAW39HOey2OpABUvA61njxVxsTqPEmhA7/
An6w8Qf4F2Ks9iQAWqO9A60Op4lU/DwWB8uXvjMZ0A8ICJZapNtHQpvlXcPPzFN6
O0zkjqkbkGeftwDZPwa/mq3D13MJyZd4IPrUVJDkAoPHFiAPvFK0reOdbiOc34P2
9rh0ZwuVRWs8/eCI8wOhxjM/b5J4WQF5Gy9SouQhyx2ehmHh7shv1j1GHLrCz3nP
LBgON/U4vhbOxnSWMUP/nhUngJmTRV8AjDNWggBnBpcKyAVF2XE=
=MbHQ
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
