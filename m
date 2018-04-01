Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0107.hostedemail.com
 [216.40.44.107])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ddq92SdTzF22N
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 01:01:41 +1000 (AEST)
From: Shea Levy <shea@shealevy.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
In-Reply-To: <87a7ur10k3.fsf@concordia.ellerman.id.au>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
 <20180328203659.18692-15-shea@shealevy.com>
 <1522269853.12357.135.camel@perches.com> <874lkzudkc.fsf@xps13.shealevy.com>
 <87a7ur10k3.fsf@concordia.ellerman.id.au>
Date: Sun, 01 Apr 2018 11:01:36 -0400
Message-ID: <87efjzrmwf.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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

Hi Michael,

Michael Ellerman <mpe@ellerman.id.au> writes:

> Shea Levy <shea@shealevy.com> writes:
>
>> Joe Perches <joe@perches.com> writes:
>>
>>> On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
>>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>>
>>> Most people seem to want some form of commit message
>>> and not just your sign-off.
>>>
>>
>> Ah, if the subject is insufficient I can add some more detail.
>
> Yeah please do.
>
> Seeing this patch in isolation, with no change log, I might think it's
> safe for me to just apply it.
>
> But that would break the build because I don't have patch 1.
>
> So for starters you need to explain that part, eg something like:
>
>   A previous patch in the series added a weak definition of
>   free_initrd_mem() in init/initramfs.c.
>
>   The powerpc implementation is identical, so it can be removed allowing
>   the generic version to be used.
>
>
> Then you could also tell me if you did/didn't build/boot test it.

Thanks for the feedback, can you let me know if the recently posted v6
fits the bill?

>
> cheers

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlrA9FAACgkQXAvWlX2G
/ieBKBAAk/VCetteefqZltIXAjkY4l/v8JW1hxDADgmU74eMx14ZgZ4ZjJfw1/Gu
gYA0xiz+gZE3+ciDx56n6GlY01Ch3RbZ5CqgFA3v8VORzKJYAzPEET5C+ZKd4sCV
hxkUf8CadMiIcK077p7quHys8HT2hdQc7Jtv+DhkJYhpeUc9QbUmY+Kh9kd3LFTv
pZXdgAfK1bwyVGbhiFwD75k8wK70PtmXN2j5AnpE0JpSCNkuannRakrECCewa7wV
6LZ99wgbokm+/3GrCoPP4zBREkX/rAtXlDYqT0mSYO7c6F8phzA7o+u9HSezJ9Q2
TcOJspb3HC96ZJzpTguDjD48btmMHVwGhxdQwvJdpV1PfTrL1JBTBvfZbvQL3pST
khLtXDUGbqloMV6/904TkeKYuESHOuOZhjXNrhnWQ9GkUyqIjhicbEk8CotTzxN7
6VI6woqE0RLAKMkhcvZQYa8QA8qeSJrfESGtsDmc5HarhxUabRQtH2jlsJO/SJmk
n8rGWBfXUzatv9+Jt6akzPfmOD+fO/3rIQ5BTaJvRXigI6l8wqOLWRSyWst/gIrX
TCjdNw30HcB8vSnNfDNcQRsIERsfg/uN+j0lQFu6keuSqAEMQFr5QLRlyqiD1MsA
2sTKQXkMTRwrbCazgSn4MzLdJ76wDRfTvNnMvR/vKm2Le4NPppU=
=nzH9
-----END PGP SIGNATURE-----
--=-=-=--
