Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E76C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:01:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67150218AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wo0S27p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67150218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Pn4n20btzDqQW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 11:01:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Pn2n2D9szDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 10:59:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Wo0S27p7"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44Pn2n0wWYz9sR2; Thu, 21 Mar 2019 10:59:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1553126369;
 bh=hzTD6xwQxfraxwlf/4wwIgMRSI0P3nnMPOSx/S0w7/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wo0S27p7mjPm4XcMAYBJqWxg1HRwINloEL34fss6hH5I11cGVN9XP4lVjGzxLtBU4
 1JQsbIs0gQ/f5+GzZmp8zYqViWvld16me1cNAvbH/h5QWJFMQ+TXrBXTCVDh1GsmQy
 NaZeky6zQKXfUABebNpaZmZKaRwLawH2EitwHxLA=
Date: Thu, 21 Mar 2019 10:56:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Message-ID: <20190320235600.GB2501@umbus.fritz.box>
References: <20190315081835.14083-1-aik@ozlabs.ru>
 <20190315081835.14083-3-aik@ozlabs.ru>
 <20190319103619.6534c7df@x1.home>
 <20190320043824.GG31018@umbus.fritz.box>
 <20190320130908.4f837995@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190320130908.4f837995@x1.home>
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


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 01:09:08PM -0600, Alex Williamson wrote:
> On Wed, 20 Mar 2019 15:38:24 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Mar 19, 2019 at 10:36:19AM -0600, Alex Williamson wrote:
> > > On Fri, 15 Mar 2019 19:18:35 +1100
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >  =20
> > > > The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links a=
nd
> > > > (on POWER9) NVLinks. In addition to that, GPUs themselves have dire=
ct
> > > > peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment the PO=
WERNV
> > > > platform puts all interconnected GPUs to the same IOMMU group.
> > > >=20
> > > > However the user may want to pass individual GPUs to the userspace =
so
> > > > in order to do so we need to put them into separate IOMMU groups and
> > > > cut off the interconnects.
> > > >=20
> > > > Thankfully V100 GPUs implement an interface to do by programming li=
nk
> > > > disabling mask to BAR0 of a GPU. Once a link is disabled in a GPU u=
sing
> > > > this interface, it cannot be re-enabled until the secondary bus res=
et is
> > > > issued to the GPU.
> > > >=20
> > > > This defines a reset_done() handler for V100 NVlink2 device which
> > > > determines what links need to be disabled. This relies on presence
> > > > of the new "ibm,nvlink-peers" device tree property of a GPU telling=
 which
> > > > PCI peers it is connected to (which includes NVLink bridges or peer=
 GPUs).
> > > >=20
> > > > This does not change the existing behaviour and instead adds
> > > > a new "isolate_nvlink" kernel parameter to allow such isolation.
> > > >=20
> > > > The alternative approaches would be:
> > > >=20
> > > > 1. do this in the system firmware (skiboot) but for that we would n=
eed
> > > > to tell skiboot via an additional OPAL call whether or not we want =
this
> > > > isolation - skiboot is unaware of IOMMU groups.
> > > >=20
> > > > 2. do this in the secondary bus reset handler in the POWERNV platfo=
rm -
> > > > the problem with that is at that point the device is not enabled, i=
=2Ee.
> > > > config space is not restored so we need to enable the device (i.e. =
MMIO
> > > > bit in CMD register + program valid address to BAR0) in order to di=
sable
> > > > links and then perhaps undo all this initialization to bring the de=
vice
> > > > back to the state where pci_try_reset_function() expects it to be. =
=20
> > >=20
> > > The trouble seems to be that this approach only maintains the isolati=
on
> > > exposed by the IOMMU group when vfio-pci is the active driver for the
> > > device.  IOMMU groups can be used by any driver and the IOMMU core is
> > > incorporating groups in various ways. =20
> >=20
> > I don't think that reasoning is quite right.  An IOMMU group doesn't
> > necessarily represent devices which *are* isolated, just devices which
> > *can be* isolated.  There are plenty of instances when we don't need
> > to isolate devices in different IOMMU groups: passing both groups to
> > the same guest or userspace VFIO driver for example, or indeed when
> > both groups are owned by regular host kernel drivers.
> >=20
> > In at least some of those cases we also don't want to isolate the
> > devices when we don't have to, usually for performance reasons.
>=20
> I see IOMMU groups as representing the current isolation of the device,
> not just the possible isolation.  If there are ways to break down that
> isolation then ideally the group would be updated to reflect it.  The
> ACS disable patches seem to support this, at boot time we can choose to
> disable ACS at certain points in the topology to favor peer-to-peer
> performance over isolation.  This is then reflected in the group
> composition, because even though ACS *can be* enabled at the given
> isolation points, it's intentionally not with this option.  Whether or
> not a given user who owns multiple devices needs that isolation is
> really beside the point, the user can choose to connect groups via IOMMU
> mappings or reconfigure the system to disable ACS and potentially more
> direct routing.  The IOMMU groups are still accurately reflecting the
> topology and IOMMU based isolation.

Huh, ok, I think we need to straighten this out.  Thinking of iommu
groups as possible rather than potential isolation was a conscious
decision on my part when we were first coming up with them.  The
rationale was that that way iommu groups could be static for the
lifetime of boot, with more dynamic isolation state layered on top.

Now, that was based on analogy with PAPR's concept of "Partitionable
Endpoints" which are decided by firmware before boot.  However, I
think it makes sense in other contexts too: if iommu groups represent
current isolation, then we need some other way to advertise possible
isolation - otherwise how will the admin (and/or tools) know how it
can configure the iommu groups.

VFIO already has the container, which represents explicitly a "group
of groups" that we don't care to isolate from each other.  I don't
actually know what other uses of the iommu group infrastructure we
have at present and how they treat them.

So, if we now have dynamically reconfigurable groups which are a
departure from that design, how can we go from here trying to bring
things back to consistency.

> > > So, if there's a device specific
> > > way to configure the isolation reported in the group, which requires
> > > some sort of active management against things like secondary bus
> > > resets, then I think we need to manage it above the attached endpoint
> > > driver. =20
> >=20
> > The problem is that above the endpoint driver, we don't actually have
> > enough information about what should be isolated.  For VFIO we want to
> > isolate things if they're in different containers, for most regular
> > host kernel drivers we don't need to isolate at all (although we might
> > as well when it doesn't have a cost).
>=20
> This idea that we only want to isolate things if they're in different
> containers is bogus, imo.  There are performance reasons why we might
> not want things isolated, but there are also address space reasons why
> we do.  If there are direct routes between devices, the user needs to
> be aware of the IOVA pollution, if we maintain singleton groups, they
> don't.  Granted we don't really account for this well in most
> userspaces and fumble through it by luck of the address space layout
> and lack of devices really attempting peer to peer access.

I don't really follow what you're saying here.

> For in-kernel users, we're still theoretically trying to isolate
> devices such that they have restricted access to only the resources
> they need.  Disabling things like ACS in the topology reduces that
> isolation.  AFAICT, most users don't really care about that degree of
> isolation, so they run with iommu=3Dpt for native driver performance
> while still having the IOMMU available for isolation use cases running
> in parallel.  We don't currently have support for on-demand enabling
> isolation.

Ok.

> > The host side nVidia GPGPU
> > drivers also won't want to isolate the (host owned) NVLink devices
> > from each other, since they'll want to use the fast interconnects
>=20
> This falls into the same mixed use case scenario above where we don't
> really have a good solution today.  Things like ACS are dynamically
> configurable, but we don't expose any interfaces to let drivers or
> users change it (aside from setpci, which we don't account for
> dynamically).  We assume a simplistic model where if you want IOMMU,
> then you must also want the maximum configurable isolation.
> Dynamically changing routing is not necessarily the most foolproof
> thing either with potentially in-flight transactions and existing DMA
> mappings, which is why I've suggested a couple times that perhaps we
> could do a software hot-unplug of a sub-hierarchy, muck with isolation
> at the remaining node, then re-discover the removed devices.

Ok, so I feel like we need to go fully one way or the other.  Either:

1) Groups represent current isolation status, in which case we
   deprecate vfio containers in favour of fusing groups beforehand,
   and we need some new concept ("isolation atoms"?) to represent what
   isolation is possible

or

2) Groups represent potential isolation, with a higher level construct
   representing current isolation.  This could involve making vfio
   containers essentially a wrapper around some more generic concept
   ("isolation clusters"?) of a group of groups.

> Of course when we bring NVIDIA into the mix, I have little sympathy
> that the NVLink interfaces are all proprietary and we have no idea how
> to make those dynamic changes or discover the interconnected-ness of a
> device.  Thanks,

Yes, well, no argument there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyS0wsACgkQbDjKyiDZ
s5Kg4w/+L87T+/TL8ek8in/AxkPDXadsNqxXRyholfb51R6QMcS+POKpIkMEFpbB
PSb1mKiv+x6OY9pbqU6ksrCnNKwi+Fwi7vlO4NwhIRkiyrTRp9tXapvrO45a0AUq
kHPcTty6A7SNgRJakftwhEAmhA1V6EUf2D815KBLg6rNEX/4YPseNnob/luSg0C9
1Ai1H9YRk9KYisAN/IuLNiSZ5WJo8HpFgkbvbP5xXW0Y3IIFuAV0NtE8fe9exgxj
BJOMbqTjcXD/EjUVonq7smE81WgGgHF+Ul2vJ4cFiwhU+xd+jVhrhXiWCNglWVCS
vUoapL4CCgYWlFe0vTCwcJWyRQFcfuxbQypqS9scwT9OA4ZklhMPWiO+EmT/jjZE
ZJN5dPCWHvtv6aNGRkW1Cy4UVVqDZ1ZsiOIJ7tgh79WubIBIhEa1St2+q5hc2IIZ
kmiI69Ixbfvi55ZC62dVBrsov+SnBmojdkESdZMan4pFMPqfBqoewYtZg0vAFySr
bagrQp0Pxw11i63AZ+PLeaBpQDvkdb48MyOxLplTqA/ytlkBoLq+7HpAyGQQdOe9
tho7k8/80UJDXuOtEOEJE8mZn/RY2x6lmFfKFwLj/OiOw4EHKUCI68OFtRuCZHsC
/iy/CYb54bJvskiyTVZqNXQvMjzVAPeM6ESvhAWBt0QMo1XyZ00=
=U6t7
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
