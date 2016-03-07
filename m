Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2ED51A0118
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:31:00 +1100 (AEDT)
Date: Mon, 7 Mar 2016 15:58:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 1/9] KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO
 capability number
Message-ID: <20160307045827.GJ22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
In-Reply-To: <1457322077-26640-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:09PM +1100, Alexey Kardashevskiy wrote:
> This adds a capability number for in-kernel support for VFIO on
> SPAPR platform.
>=20
> The capability will tell the user space whether in-kernel handlers of
> H_PUT_TCE can handle VFIO-targeted requests or not. If not, the user space
> must not attempt allocating a TCE table in the host kernel via
> the KVM_CREATE_SPAPR_TCE KVM ioctl because in that case TCE requests
> will not be passed to the user space which is desired action in
> the situation like that.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index c251f06..080ffbf 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -863,6 +863,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_HYPERV_SYNIC 123
>  #define KVM_CAP_S390_RI 124
>  #define KVM_CAP_SPAPR_TCE_64 125
> +#define KVM_CAP_SPAPR_TCE_VFIO 126
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3QpzAAoJEGw4ysog2bOSBSkP/1FwMRsESKxuV+02sf9LlPyx
vyRk4y/BvtlmNkzMrefOUDdmHpm86lox9Dh9L8bMyDVq79IyptShcHcCeCEJwLsM
aHhDBDZldyeSd8GPhICIStC243/HMW2ha5MqnnGv+cmFbuBs1b0iE/bghx0SnW9K
TypAJa6Fciwg9vlu6oKgir7qYqFQUU7w6x8bL6LkU5Ms7d/emdXhSkgY5PvKE1l+
5Gjq0JmST104p4zx+RrsJJKHnnlat84PmKXLpJyzlyokBA7eXJ3+M4P1rPXaEX5L
3Ld/rAf4tjlfCpKfwPJg8yTAIyEUteCLA3c8SGXW0yuMfYwGUbitj9e2/BsyjCuq
6SkGkPwjQZk0o/FuCMdGtxw28GeTn77ISs2ILkECcZtRQqkJdpEywMSbYtAQJ30+
9uMhCfPYsWhsaJnsrFACNWYaHljb2r/oD/DJRts1ph/JM6whYh7trHPLu0OBZ/sj
JTzk7XmoSJ1He9XxLcPzH7/8rBb6yOdrcYt+H57wawbi2PROsxH3PQPLjSurHKPs
er1tOk0OJM5TCd/usuvEMRZMaqVg6UK7jd8LuKT7DuVzjvorAG7rOUChCara+JdW
mvQ0lLZmsPUpALKEBg3SEZa/6Whd6jZRHLYIvR2WocBiR3UfEdMVhtoXB9gxqsZH
3npAMhEQVAXnvxrwyt7w
=bKlv
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
