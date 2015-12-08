Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D76AF1A0F2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 20:05:55 +1100 (AEDT)
Date: Tue, 8 Dec 2015 16:29:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 8/9] KVM: Fix KVM_SMI chapter number
Message-ID: <20151208052924.GT20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-9-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JHjDRUnf1JOMxzko"
In-Reply-To: <1442314179-9706-9-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JHjDRUnf1JOMxzko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Sep 15, 2015 at 08:49:38PM +1000, Alexey Kardashevskiy wrote:
> The KVM_SMI capability is following the KVM_S390_SET_IRQ_STATE capability
> which is "4.95", this changes the number of the KVM_SMI chapter to 4.96.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JHjDRUnf1JOMxzko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZmq0AAoJEGw4ysog2bOSKXMP/2wNQnmYwLHKenBYva28VbYD
f29jGYlDw30SBsnykZoQLd4d5pRfi/I4uujLG7qQCXxdO2qTam66K4nZw+J1gO5Y
++DrxHGUr762l3Y1kdUhLFkGKOx2JR2qxua6GRNjw5Ax8+yXbwNAFKhrn6Bo5PRP
QCr2NOz9wgNOibGxnMfZXwyhtaxHe53s0aYK/Ip+eWeZYYIJlG5vKAVslGXOMqyf
vbOnrTse1/SpGs+x4Lt+yoO5eEBAFe4qVQtOYvKLip2f2MjIdzcCExQaGxShLmm5
BnMeUKvwvwnR6k0Lp+RKnCf7/HxhKEz/cimbIdfPtlQACZ6SNXlipzxhIy5ph5UK
bpvdKBBUAH1NIXeytZyAY9uGqT3eCVpFSeoovs5khM61GCBfyKL9mqdClDs1hQ5m
sTjyTrhIWcc/jruCyQBMUpaMkTF2rGcbORfSAvofqzS88dxKUWz91Dd72CLlGELZ
/adcjcaPOEEWtlAnp9d55LMpDQ+2+s1fHbJoQjl2M4K1wHwX/frgIvExVsidoh+V
7L5LoHCTOckC4cpuqX75VDxwsR2Wx3q7CjlpGdAqHSmwvA00L5XMII/2Uvsj0N1G
0UScLBEg4SNSVi0t2/N+l0nj904krHYPCsZup76k0o57FJF2oJDGUf71yfkawXDv
bzbMWKhKuw1cJMGK1jL8
=6CZq
-----END PGP SIGNATURE-----

--JHjDRUnf1JOMxzko--
