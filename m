Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkYkW5wbHzDwQl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 12:25:55 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id w68so12146314pgw.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 17:25:55 -0800 (PST)
Subject: Re: [PATCH kernel v2 09/11] vfio iommu: Add helpers to (un)register
 blocking notifiers per group
To: David Gibson <david@gibson.dropbear.id.au>
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-10-aik@ozlabs.ru>
 <20161221060418.GF13024@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6a89bf6d-76bf-1a7d-371f-5d77a4cb810e@ozlabs.ru>
Date: Thu, 22 Dec 2016 12:25:47 +1100
MIME-Version: 1.0
In-Reply-To: <20161221060418.GF13024@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Nd8nwmc3DHvv1wSNdpx35j71gGjRf7Xu"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Nd8nwmc3DHvv1wSNdpx35j71gGjRf7Xu
Content-Type: multipart/mixed; boundary="aq9kmxdOBxsm8kHM6Mlwjxvp7qw3EG30Q";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <6a89bf6d-76bf-1a7d-371f-5d77a4cb810e@ozlabs.ru>
Subject: Re: [PATCH kernel v2 09/11] vfio iommu: Add helpers to (un)register
 blocking notifiers per group
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-10-aik@ozlabs.ru>
 <20161221060418.GF13024@umbus.fritz.box>
In-Reply-To: <20161221060418.GF13024@umbus.fritz.box>

--aq9kmxdOBxsm8kHM6Mlwjxvp7qw3EG30Q
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 21/12/16 17:04, David Gibson wrote:
> On Sun, Dec 18, 2016 at 12:28:58PM +1100, Alexey Kardashevskiy wrote:
>> c086de81 "vfio iommu: Add blocking notifier to notify DMA_UNMAP" added=

>> notifiers to a VFIO group. However even though the code underneath
>> uses groups, the API takes device struct pointers.
>>
>> This adds helpers which do the same thing but take IOMMU groups instea=
d.
>>
>> This adds vfio_iommu_group_set_kvm() which is a wrapper on top of
>> vfio_group_set_kvm() but also takes an iommu_group.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Adding a second interface in parallel seems dubious.
>=20
> Should the existing interface just be replaced with this one?
>=20
> Or can the existing interface be re-implemented in terms of this one?

imho this should have been done in the first place but since Alex and I
came to a conclusion that this does not simplify anything in my patchset
(rather the opposite), I am not going to push it further now.

09/11, 10/11, 11/11 from this patchset are superseded by:
[PATCH kernel v3] KVM: PPC: Add in-kernel acceleration for VFIO


--=20
Alexey


--aq9kmxdOBxsm8kHM6Mlwjxvp7qw3EG30Q--

--8Nd8nwmc3DHvv1wSNdpx35j71gGjRf7Xu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYWyubDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC51dwP/0b/
GO/opaI32/ZVc1XxMKFhGN9L2kT7ciAnaiEii/gPv+RQPfbxDK5EUi0jOwL/e5XV
yRp+lnJjP8k5CqmZozGvF9l4hcdB02+NBaVSqe08FG5cyP1DqwkasNA1FaJgImdW
2Z2zz8Bn4KzWOUPPSfokrRx9lBtDGJhxnRxUz+NvqBmlWWBGflTKiCMDwZpBKymT
vHtwMyXxK+m/ohf0Dvpc5skLrK2gA9g1fiUOM68yVwfIeBQ2BTWB2qxnlH7sY8Hr
CnhYGyBWW9W/lEhw6uEj74CWbQm4lfWfk8v6lAZBBxtDw1dRUUhscBybyRWNMebl
fXpGHf2tEWo+N0Cj4GXVLnE2U31D5stcLmqxGq2T5y226Nj634YGEFyjcJ/iL2gG
bhhNd6SUjfSo494UWGy1930uIeo/mr8iCjbTtHS7QNha921yMXIEbJr9C/Ihwv9I
EFDOMaCd5glgO4K32FcGvdli9p7lZMXMIs6vIHwZeRzgMU4EdajctR/t+zL+ZvNe
mlY0p7EHAeNU9P3UJS3wucyciPNJwYY/I/OVbUNDWeLLBQvrb4xHnTJvYgqSWhrl
tRrLhRa2muNLyzdd3wdjfXspc+OiH01NwSs9k4CWv2jy/CcIqmH0QngBE1Ll8G96
mAoQcaNUi2aHco3gREnxPlYXGgil5TM69W9jCdkk
=nmSU
-----END PGP SIGNATURE-----

--8Nd8nwmc3DHvv1wSNdpx35j71gGjRf7Xu--
