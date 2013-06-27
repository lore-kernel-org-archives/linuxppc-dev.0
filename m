Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 0D8262C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 17:50:27 +1000 (EST)
Date: Thu, 27 Jun 2013 17:50:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2] vfio: add external user support
Message-Id: <20130627175019.689f6c4c4ef92d6562cbd450@canb.auug.org.au>
In-Reply-To: <1372317260-6438-1-git-send-email-aik@ozlabs.ru>
References: <20130627164752.657c165ec4492e5248945a51@canb.auug.org.au>
 <1372317260-6438-1-git-send-email-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__27_Jun_2013_17_50_19_+1000_FHk1xp9mtV99U7DK"
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Jun_2013_17_50_19_+1000_FHk1xp9mtV99U7DK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexy,

Thanks for the changes.

On Thu, 27 Jun 2013 17:14:20 +1000 Alexey Kardashevskiy <aik@ozlabs.ru> wro=
te:
>
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index ac8d488..7ee6575 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -90,4 +90,11 @@ extern void vfio_unregister_iommu_driver(
>  	TYPE tmp;						\
>  	offsetof(TYPE, MEMBER) + sizeof(tmp.MEMBER); })		\
> =20
> +/*
> + * External user API
> + */
> +int vfio_group_add_external_user(struct file *filep);
> +void vfio_group_del_external_user(struct file *filep);
> +int vfio_group_iommu_id_from_file(struct file *filep);

Just being picky, but all the other function declarations in that file
state "extern" explicitly.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__27_Jun_2013_17_50_19_+1000_FHk1xp9mtV99U7DK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRy+6/AAoJEECxmPOUX5FEHB4P/0zvgpoHLvaSsXy+DmYPi4d8
NI1J19YnPQsgg+cOF6ju9KECwFW4VKw0ZjjMtLfodmceBhPspLzPtvjj61gjSVsG
FCvii9RRuFlinuwqf1tQHyEC2YWG9xbBb6AR6ZHM357migUEQROCfJCTvJIer+2P
Z8R762/KPIRuUpuREy6btQVTPWhiVbF56eE5/EWtJ/iYI/F2hVlhNXGvQjTT1xud
43eqV8ONdweNnrRxWa+Si3CMeGBzHIPgvjJb60fh93arhoccFx4FkydQhsod1CFC
yvnHThvI0//2VefZZSzAVCZmBKutAUsfOTMmBcgQNpaksYeckawaM2nwFvmVk51w
ye0Y8Z79pPVG14GH5ja4T/SmZnZ7L2LnTm6pKrFJMRhaOsceoHeSKLcRZyoCSjji
TEu/A6Rr6+oJu0lXvw/rOyK7F2upZLBRTf5QaA9/jDiN9XL5faq2M7cx158ic3dP
eMl+41eZl3M9lG8pXaUx0lAxkcAOCd0ZyODwdWtZXz8wvlAaCCJ9njaKWBdevwMs
yki6xaM4C/6yrC2mFax0Dm1tXGnY+gzE1aYmpi0Mm22q+2cWyHLEYtpwVRbBlWM+
WlowO6W/bjuJwKyGm0QjW42Y0t0dtL8oGCRJh4o7AUOHYFDrwLp78++DpWzBQu6/
wGDYiwEOAfyrrDegtbbP
=4MRZ
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Jun_2013_17_50_19_+1000_FHk1xp9mtV99U7DK--
