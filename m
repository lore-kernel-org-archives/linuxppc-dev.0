Return-Path: <dja@axtens.net>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DCD11A0BCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 11:34:38 +1100 (AEDT)
Received: by pacfl14 with SMTP id fl14so2806234pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2015 16:34:36 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: "Geyslan G. Bem" <geyslan@gmail.com>
Cc: "Geyslan G. Bem" <geyslan@gmail.com>, kvm@vger.kernel.org,
 Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH] kvm: remove unused variable 'vcpu_book3s'
In-Reply-To: <1449013410-19103-1-git-send-email-geyslan@gmail.com>
References: <1449013410-19103-1-git-send-email-geyslan@gmail.com>
Date: Wed, 02 Dec 2015 11:34:21 +1100
Message-ID: <878u5dk7si.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Geyslan G. Bem" <geyslan@gmail.com> writes:

> The vcpu_book3s struct is assigned but never used. So remove it.

Just out of interest, how did you find this? Compiler warning? Static
analysis? Manual inspection?

Thanks in advance!

Regards,
Daniel

>
> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_64_mmu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_6=
4_mmu.c
> index 774a253..9bf7031 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
> @@ -377,15 +377,12 @@ no_seg_found:
>=20=20
>  static void kvmppc_mmu_book3s_64_slbmte(struct kvm_vcpu *vcpu, u64 rs, u=
64 rb)
>  {
> -	struct kvmppc_vcpu_book3s *vcpu_book3s;
>  	u64 esid, esid_1t;
>  	int slb_nr;
>  	struct kvmppc_slb *slbe;
>=20=20
>  	dprintk("KVM MMU: slbmte(0x%llx, 0x%llx)\n", rs, rb);
>=20=20
> -	vcpu_book3s =3D to_book3s(vcpu);
> -
>  	esid =3D GET_ESID(rb);
>  	esid_1t =3D GET_ESID_1T(rb);
>  	slb_nr =3D rb & 0xfff;
> --=20
> 2.6.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWXjyNAAoJEPC3R3P2I92FLaoP/itNYf+NtoxK9Ifo3ID3MOgY
9+M7yve7xA7sHet2ZWFtK+PZL3jO9V2QQW7CcTTVOI6eDK+a+wgWcd4lDGFm5z5h
RntWdUwqFGUiiHKULPE0RWwt4N8EVyN91b4Kkbk4L14RsABMIMj7ewHW2jv1NsEB
UCnZwTZUK4npU7JNu1s0n7bFzWU4H5X9nPgetzK6Fn7De8zfQbmJQmFuB2k2YNQn
zWZwoO7eoCnaCx3r70E09AuU5ZkKpT4y8v5M7EtsCNkzgsgV/YpjqoXTausi3Cxi
2WWV9FI85hfQ5XC0e5+7Bfr+4Rfkt7tQsr6Fi2rAVuqK2dKqNf903yz9mYZgqB3q
fdGa/SVDmqXxSaKaoHf+w1qOA6IV7cPA6JXpHHLJV9NQHG0WOTTnYYdf3SBO7b4e
ZwBiXFure8873QCK4WuV/J/BfoOlVxYEQES2GZY9dtw2v2bMK4raSodwTJ32MyMQ
ryib1ASVGaeYVhPv0aplu+o3ODhrT9R7/NSeyP7pDmwzPAiiDAcZouJ3CBzZvGSY
e688iurOzDV/5XTsjqA36onMKvE/VB62v4BlQM638If2Qo1kRPnqjlFODW6OJqMQ
haVluf4CPlwGQsGqVmvNzqxCR+cGMoKvkKbh6miJZkrr7NDM5V/KkKjdjtEr6FPO
yfo9DsapjLIRbBQvAYkg
=imx/
-----END PGP SIGNATURE-----
--=-=-=--
