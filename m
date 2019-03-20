Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F549C10F05
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:15:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97E120857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jb+5w8Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97E120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PKRL4zJ2zDqCW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 17:15:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PK9j6SktzDqMx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 17:03:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="jb+5w8Y5"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44PK9j4CMyz9sNG; Wed, 20 Mar 2019 17:03:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1553061833;
 bh=3yWqj9YnRo3mRLpLC7eWddeuwz0kboGPtpvYkbICsg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jb+5w8Y5DvxnnBnUbvfidNhWomXOQGxsiA/JUOTB99v8h77IJpmjWKy4RdSehC/ds
 OpOF0Jj5fPKbt8eFQrHyNPqpRIDES9o8zQ/j09tEc2WCggcnLwZKxZnethgCTXWoRv
 RbU4QYDUEaSrgCR59dzhyJDomoZx2AgjCWDOyZn0=
Date: Wed, 20 Mar 2019 15:38:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Message-ID: <20190320043824.GG31018@umbus.fritz.box>
References: <20190315081835.14083-1-aik@ozlabs.ru>
 <20190315081835.14083-3-aik@ozlabs.ru>
 <20190319103619.6534c7df@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline
In-Reply-To: <20190319103619.6534c7df@x1.home>
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


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 10:36:19AM -0600, Alex Williamson wrote:
> On Fri, 15 Mar 2019 19:18:35 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links and
> > (on POWER9) NVLinks. In addition to that, GPUs themselves have direct
> > peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment the POWERNV
> > platform puts all interconnected GPUs to the same IOMMU group.
> >=20
> > However the user may want to pass individual GPUs to the userspace so
> > in order to do so we need to put them into separate IOMMU groups and
> > cut off the interconnects.
> >=20
> > Thankfully V100 GPUs implement an interface to do by programming link
> > disabling mask to BAR0 of a GPU. Once a link is disabled in a GPU using
> > this interface, it cannot be re-enabled until the secondary bus reset is
> > issued to the GPU.
> >=20
> > This defines a reset_done() handler for V100 NVlink2 device which
> > determines what links need to be disabled. This relies on presence
> > of the new "ibm,nvlink-peers" device tree property of a GPU telling whi=
ch
> > PCI peers it is connected to (which includes NVLink bridges or peer GPU=
s).
> >=20
> > This does not change the existing behaviour and instead adds
> > a new "isolate_nvlink" kernel parameter to allow such isolation.
> >=20
> > The alternative approaches would be:
> >=20
> > 1. do this in the system firmware (skiboot) but for that we would need
> > to tell skiboot via an additional OPAL call whether or not we want this
> > isolation - skiboot is unaware of IOMMU groups.
> >=20
> > 2. do this in the secondary bus reset handler in the POWERNV platform -
> > the problem with that is at that point the device is not enabled, i.e.
> > config space is not restored so we need to enable the device (i.e. MMIO
> > bit in CMD register + program valid address to BAR0) in order to disable
> > links and then perhaps undo all this initialization to bring the device
> > back to the state where pci_try_reset_function() expects it to be.
>=20
> The trouble seems to be that this approach only maintains the isolation
> exposed by the IOMMU group when vfio-pci is the active driver for the
> device.  IOMMU groups can be used by any driver and the IOMMU core is
> incorporating groups in various ways.

I don't think that reasoning is quite right.  An IOMMU group doesn't
necessarily represent devices which *are* isolated, just devices which
*can be* isolated.  There are plenty of instances when we don't need
to isolate devices in different IOMMU groups: passing both groups to
the same guest or userspace VFIO driver for example, or indeed when
both groups are owned by regular host kernel drivers.

In at least some of those cases we also don't want to isolate the
devices when we don't have to, usually for performance reasons.

> So, if there's a device specific
> way to configure the isolation reported in the group, which requires
> some sort of active management against things like secondary bus
> resets, then I think we need to manage it above the attached endpoint
> driver.

The problem is that above the endpoint driver, we don't actually have
enough information about what should be isolated.  For VFIO we want to
isolate things if they're in different containers, for most regular
host kernel drivers we don't need to isolate at all (although we might
as well when it doesn't have a cost).  The host side nVidia GPGPU
drivers also won't want to isolate the (host owned) NVLink devices
=66rom each other, since they'll want to use the fast interconnects

> Ideally I'd see this as a set of PCI quirks so that we might
> leverage it beyond POWER platforms.  I'm not sure how we get past the
> reliance on device tree properties that we won't have on other
> platforms though, if only NVIDIA could at least open a spec addressing
> the discovery and configuration of NVLink registers on their
> devices :-\  Thanks,

Yeah, that'd be nice :/.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyRw74ACgkQbDjKyiDZ
s5LZFBAAr/6ubfG9uvZRYQAbILZ1yNBlp5aK7i6N6T2SiSCSdmexxVDoSKtnxxpJ
Z/H8XT9bhftv+eLzTpqsNeq/Jzyc9vixxwYukcIf13+l1dfvzs6V8uoSQIjPp3Q2
r/FeRR1nGiorXiVwZm44GieWKTG88Rt0+zKW93gjwdOGCs5wu4zL+tLF2OJFARkQ
fLBDcOgnD0sJ70XzLcNtz8oA3uAELFluFjBKXNCMzo2WpuQrOhp1WtSEhzBiAz7h
gjClrxbhc9Bp3fRihKR9IS495+Y3TJUDfv1rF0wJqo7oW9wXDjMmtzwNSVn2UQ1c
SL5tG3h20UwkluQw1aAEVX5fYAglXtIOP7OCq3sjltci/O0NzSIC6hRj6zoDbUeB
y36PSpnLiof76SNhZi8xfzL+d/2jxX5sHudyKmLXSE8DnKn6+FcE87Kq8btiwfm7
6cqhdaPXJy1HCxwPDPMcK+vQkEgngp96RHk/3le6eYhlaIZxbg+3FfRYQkuHbiMa
viQ4ENm/VoN/s64oYVjtIAcW2eWQoqEIxS25eKj1zkGhtbAzlQW9Wpa+OAju1Kfd
EcFKTMUsVBIj8yPeVft+9TYoWXbPoQ0xe7UAkAhifaJUo57MB9fko8LfH48sNsCJ
w8lcalKVKfZQQ2oIvQdO8cFJJWvycyvzLVfQlwnxv4weJoptBGU=
=KR2W
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
