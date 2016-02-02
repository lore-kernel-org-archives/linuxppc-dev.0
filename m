Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F37031A0061
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 12:08:30 +1100 (AEDT)
Date: Tue, 2 Feb 2016 11:57:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [RFCv2 0/9] PAPR hash page table resizing (guest side)
Message-ID: <20160202005708.GA15080@voom.fritz.box>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <56AEF20B.2030302@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <56AEF20B.2030302@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 11:20:03AM +0530, Anshuman Khandual wrote:
> On 01/29/2016 10:53 AM, David Gibson wrote:
> > Here's a second prototype of the guest side work for runtime resizing
> > of the has page table in PAPR guests.
> >=20
> > This is now feature complete.  It implements the resizing, advertises
> > it with CAS, and will automatically invoke it to maintain a good HPT
> > size when memory is hot-added or hot-removed.
> >=20
> > Patches 1-5 are standalone prerequisite cleanups that I'll be pushing
> > concurrently.
> >=20
> > David Gibson (9):
> >   memblock: Don't mark memblock_phys_mem_size() as __init
> >   arch/powerpc: Clean up error handling for htab_remove_mapping
> >   arch/powerpc: Handle removing maybe-present bolted HPTEs
> >   arch/powerpc: Clean up memory hotplug failure paths
> >   arch/powerpc: Split hash page table sizing heuristic into a helper
>=20
> A small nit. Please start the above commit message headers as
> "powerpc/mm:" instead, which sounds more clear and uniform with
> patch series related to other subsystems.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWr/7kAAoJEGw4ysog2bOSC1kP/3YsRV91C8T5g7bnsqI6XDyi
MoH7N04CO3rVD8BxCb6qBQVCbcj5B8qnxLVKhTFGj8yWpuhseevwUj58WKKVd5lY
k1VNvyy2wfSoyqGs7/tf3hfmehDhVzE99N3h02mOj5ptoc5M1t5YLeNPW+yH1q4U
E7jAlf9od/4SO+7jeNF+bLPzOx3rK+fM0jweMOUKPwqdna3dqooquY6+4FzUddIj
TKYs8hwo/Hzj6B++UEeFJMhcf82vu7PCxrF7FSO98kIGbY5tYydj46nWVlV1yX5z
943WPAx3Mhw4wA1tk5GgAHSiurcPpSST8vb1CwVqoo2XRI/F2H4az+21LOlLsMFb
GuczKQWfl+7Igwvdlqy2bMRR5GpQBgZ46r+sFhDJkGT+zyATkIqJRjSBXKKjRwUp
RLAc5C3aeR7qT1dq8RSMu6fYRQCWXPakVZccdWDtXmPfN4d2xZZpnMKJaoTy15/N
OVgz1VZdm/9iX3o5B8EKd6ydIJdaMoJ21E293s+x4pkYAICjZ0dQoADzHdxpryfJ
bNGwmXoxy9mvVUFuqF6cxjrMGqvb4RDn1rIVSs1/eun99TmChNg11dflybNs2tvy
L1FiDV75jPIbttL1QRbvGiwYaue3x0RVd5NwPhYhOQ6we4fDTb5lKQC2wFLavM4/
4HH9gdbwTagvUV2eRrw7
=Efpo
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
