Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 04:36:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C8220883
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 04:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fdwN+qUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C8220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SM0D2QmFzDq77
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:36:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SLyF6CRgzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 15:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="fdwN+qUn"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44SLyF3DGnz9sSq; Mon, 25 Mar 2019 15:34:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1553488469;
 bh=eDGejTSbTW3TDTmlWKX1kYx08XgO4v6XzHPVzYLKlfc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fdwN+qUnidkQRow3RVe1QLq0b8eLaiwl8cTrGjD4giWHkhiPG3iFmNsp0hqh39ATl
 CfoTIZBgWTC5X1RPwk9YCiTbwiTXi46XLlzRMJDI5oi9Rrz6nVFdKGel6K8kAPhigx
 Y3SvfjGvHiPZURDc3DdwPuQpmkXHqJPvmYcLxIB0=
Date: Mon, 25 Mar 2019 11:57:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190325005710.GC29295@umbus>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20190323165456-mutt-send-email-mst@kernel.org>
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
Cc: Mike Anderson <andmike@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2019 at 05:01:35PM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> > Michael S. Tsirkin <mst@redhat.com> writes:
[snip]
> > >> > Is there any justification to doing that beyond someone putting
> > >> > out slow code in the past?
> > >>
> > >> The definition of the ACCESS_PLATFORM flag is generic and captures t=
he
> > >> notion of memory access restrictions for the device. Unfortunately, =
on
> > >> powerpc pSeries guests it also implies that the IOMMU is turned on
> > >
> > > IIUC that's really because on pSeries IOMMU is *always* turned on.
> > > Platform has no way to say what you want it to say
> > > which is bypass the iommu for the specific device.
> >=20
> > Yes, that's correct. pSeries guests running on KVM are in a gray area
> > where theoretically they use an IOMMU but in practice KVM ignores it.
> > It's unfortunate but it's the reality on the ground today. :-/

Um.. I'm not sure what you mean by this.  As far as I'm concerned
there is always a guest-visible (paravirtualized) IOMMU, and that will
be backed onto the host IOMMU when necessary.

[Actually there is an IOMMU bypass hack that's used by the guest
 firmware, but I don't think we want to expose that]

> Well it's not just the reality, virt setups need something that
> emulated IOMMUs don't provide. That is not uncommon, e.g.
> intel's VTD has a "cache mode" field which AFAIK is only used for virt.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyYJ2YACgkQbDjKyiDZ
s5JZyQ//SS59QY9yMVjm5dIHKUEs9Bci33j39MzpLz+QZ/rSLpgkKSlPhWZLhu70
Sk2aNBu5ILbZaomcSttinaObyDh3IuicBnwqBFvAVWoSdKrrzSPFwHOTC3w5Ncdw
pkFfxcvfr5jUzh/p3RQuBATbMJfP+/mZC+KaKseXGX2vDte2T4IqZa6SXyEdjLTO
n9I7zE4D51jmPoCbOen1E65FMRQ7MkLOXsm2GCYYL9HfgdtzDzvQ8GsG4BABUGZg
BREjDrJ5abIgeaygU69uSGbtJSOIeW1xN9SE1S6DhYj323A0VA2W9HsQCZEvjkrz
4Ix5hSqOhwLhkhstH4oJAwTsXO+mDb0UIrgt8BnqnUw4OLyDDf1ukf/qf0lQgTSW
k9c15llwqGFj9uUttu5ZcsCswYbgpug0JjNQn9ebBP9yoQIEZEerX3FBnmF8vwp2
FgGP6eFM9XnnZPNiuO1AsYSL41G8Tvhjh+cGO6MWyYm4qczY1MoPLwYoihAc+ocr
SJLZG99l77d344c1eTZeIWFZoYcq/1ZYbcfVVsFRGt8WJ+kM2YrN6zTD4+tS9zwA
gq0AHzBZUZjln8CDA2HETxgvnXSI6ieyoO3zWu1EF5y/zL3wolKVvREKCeNbcvfI
bT/RnjLgXMRSvCCxUbWPADa6lDGNtZ4STlnUf10vq7jAFlHgT+4=
=YCYB
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
