Return-Path: <dja@axtens.net>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s574n6JSTzDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 10:30:33 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so18266744pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 17:30:33 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 06/30] powerpc/ptrace: Adapt gpr32_get,
 gpr32_set functions for transaction
In-Reply-To: <87r3a5ey5i.fsf@concordia.ellerman.id.au>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
 <1469674679-8580-7-git-send-email-wei.guo.simon@gmail.com>
 <877fbxqbvd.fsf@possimpible.ozlabs.ibm.com>
 <87r3a5ey5i.fsf@concordia.ellerman.id.au>
Date: Fri, 05 Aug 2016 10:30:15 +1000
Message-ID: <874m70qcq0.fsf@possimpible.ozlabs.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:


>> Is there a nice simple fix we could deploy to squash this warning, or
>> will we just live with it?
>
> This series has been nothing but pain. Given we're already at v13, and people
> really want this support to go in, I'm going to leave it in the tree.
>
> Once it's in we can refactor the implementation, which is a bit of a mess, and
> hopefully in the process fix the warnings.

OK, I'll push this onto my stack to look at again in a couple of months.

Regards,
Daniel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXo94XAAoJEPC3R3P2I92FdN8QAMGhIDCSkIe2YOdbmDaPKGMu
r5+zLhkKtajQLVCH7YdgFVcAHqg2zBl4VEw+NrwdvpOlXFgt+Ozr5ykcCxQKYUDQ
C5El0qUq86qajSkmGQoDjZfT2g/J5lbOF/B9MdeP+nUcMnIo6MLBirehuqcsbXUL
A+UYWAkeoWzBMWnZpwG/gtQIySMJRx9Agtk3INbL34TFDyZZP76jwUIw9PO1wxuT
LU3pb/zUWNFfiQjuDIv/plDMxpl2hmZQrRSuyq8mQWnWm/fuTejR0rPI94LmHXT3
tvIC9V8uE/V9YI+n9pCjizTh0UxfRkN/9rMsOizg/fxqPt5cjKoTerG7h5FDRmGf
YPLR09OV2LXZUXQOhQrY0iaHiD1/HR91YD9LvupBasYN5FRR6uGswoSpluy450PD
UviyEH4paKtScaBIlllsReXdqef4koZRAce59yIQOlpAH/96Az8G2lZYrPnm9p1E
CvosQBobEVLdtGFULD/OG4nm7Pbd5SuzydJzNwyGpwX/xYUAPKRaHt6cAfUkRsQ9
dLusFEcNMapcJ9xBqNTuWzRSycYUvvBpKFsiPSAjR6Sdqk86qsGMw2axzxi48tBu
MgY6y8vH3eJ8NgRW0tQwi6orEPWmtBaQaKSH7b/K4vJwooVHBqauTDuX370PwEgz
0j6sCZS8VSuBjWtJjI6C
=i0Kk
-----END PGP SIGNATURE-----
--=-=-=--
