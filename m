Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0175.hostedemail.com
 [216.40.44.175])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BKqG40TFzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 07:53:44 +1100 (AEDT)
From: Shea Levy <shea@shealevy.com>
To: Joe Perches <joe@perches.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
In-Reply-To: <1522269853.12357.135.camel@perches.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
 <20180328203659.18692-15-shea@shealevy.com>
 <1522269853.12357.135.camel@perches.com>
Date: Wed, 28 Mar 2018 16:53:39 -0400
Message-ID: <874lkzudkc.fsf@xps13.shealevy.com>
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

Joe Perches <joe@perches.com> writes:

> On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
> Most people seem to want some form of commit message
> and not just your sign-off.
>

Ah, if the subject is insufficient I can add some more detail.

>
> And btw:
>
> It seems you used get_maintainer to determine who to
> send these patches to.
>
> I suggest you add --nogit and --nogit-fallback to the
> get_maintainer command line you use to avoid sending
> these patches to people like me that have done drive-by
> cleanup work on these files.

Whoops, thanks for the tip and sorry for the noise!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq8ANMACgkQXAvWlX2G
/iegcA//WYfDBfzNKkTmV0BANUabihFEaRfgTIu2pFV4FPasWT1AFDWeRI07guU/
VLD3eJVIS7xULGDWdeY9MhhOwHcNji/a6Ul7DlBxqyFBdineTnlsU0pBGRPFfwPA
BNKRrQQPos5B83JVebQOUB2wmgoN3iMDYMU1a3dWRxfqjlmDSxfglp9Zdk2X0d+P
PnZ1tTM1f7cnonluEtLsMvzkrNcp6Zl8CfClRO23L8+6+/mt9U00GV6wsOhvrbAn
HSWN3uSi5OAd9INY7zIAXwwJ+tXmXUMHy+rU5lzX35DKuI9nMIs23qpykK8FBXdl
811t+jpcgxeEoHQhbe8UH2Rx9YNGFbEkYpKQfHTv5dcBT3DM2gpOcdRGMSBGdJFK
fPEstwv2ulmyXbhGbc+v7bCaFlSTIzOpVsaZ0i4s08c4T83ebWM3T9wUIDx7hQy/
Btn17I57tZM5DnTduuAAjzvqIE8qDUyddRdrxYcIlH4/kQF5xaJXu4kmdwe0EFIZ
ojQnC0LLH3t56hSAAl4CJAHtcGHc7hizcPzfcW2ma8xJ1pvraOatgEAn6lvTvjMx
MNKT1zYami5Z5YFWyZYpTbb/cVcgxKIuSJ90KQUsuxjtBGZj3zx6HZ/mtMBwDBEw
wEC+pYxkxnbQeCUuUA2FctEDJ2okytfY1e3IVOvPGD9Io8GUZ9U=
=5dqg
-----END PGP SIGNATURE-----
--=-=-=--
