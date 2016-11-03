Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8lY61LmKzDvRL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 00:04:26 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Larry Finger <Larry.Finger@lwfinger.net>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
CC: Andreas Schwab <schwab@linux-m68k.org>, Andrew Morton
 <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Petr Mladek
 <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
Date: Thu, 3 Nov 2016 13:04:15 +0000
Message-ID: <6286107.lVdN284Pp8@np-p-burton>
In-Reply-To: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031230953.GA425@swordfish>
 <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2648178.4lm86R6J1I";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart2648178.4lm86R6J1I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 31 October 2016 18:31:43 GMT Larry Finger wrote:
> On 10/31/2016 06:09 PM, Sergey Senozhatsky wrote:
> > Hi,
> > 
> > On (10/31/16 15:50), Paul Burton wrote:
> > [..]
> > 
> >> Actually whilst this fixes the output in QEMU it has other problems. I'm
> >> still digging...
> > 
> > I propose a revert of '05fd007e46296', so you guys can find the
> > problem and fix it, not being under 'rc3' pressure.
> 
> If we were at -rc4 or -rc5, then I would agree; however, I think there is
> still time to fix the problem.
> 
> Larry

Hi Larry et al,

If you could give the v3 I just submitted a try that would be great:

    https://patchwork.kernel.org/patch/9410849/

If it still doesn't work for you then we're back to a place where I can't test 
an affected system, since QEMU pseries now works fine with my patch. Would you 
perhaps be able to get some console output by specifying console=<whatever> on 
the kernel command line? Doing that ought to be unaffected by 05fd007e4629 
("console: don't prefer first registered if DT specifies stdout-path") and 
could be a way to get us some debug output.

Thanks,
    Paul
--nextPart2648178.4lm86R6J1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGzXPAAoJEIIg2fppPBxlkJ0P/3Z+thxnHvMmmUvvjZ5zzzox
sZuERoudcGCzVgP/yafHnlYJ/EsasGIdPvcvIjEh+Uow8mjbKHfGqlp4qPs6mWRy
HrOWmPXG3ya/9+RbmaMWslSYyjIWIV6q+xbScJfja3PKYd5ikJwTQBtwOt3RXFd0
VquTPOdGWo/YFpMV5zVPIiOnXxRIvQVQmRN9nrnEx/Kb8Ix1+pypqmXmr7nEGt1j
fVDjDbFJVJ7urmd4PUwMSnvmeMCUblEpx6k0RkA/viJMMtP7gpbl5IFXI/sHTOQp
Vp6NohZhkmQEg7VnM+ISE4twOWEJB7g+1oqaQVCd+IVcKKjbTBEemV7Bc84KXcC0
ip/ntiJWSU4BHn0p0I5JSXJSuZ07U3vFE8SoRAOwibGTq1n3JLU+Hco4hqFY/Z2N
mp2nbkMThTTdqu744NrnlGbttyGKHFwCvK6F8jkQRS20tj5yzoBnG5nQI9C2lhug
1hC4p8WpJGS0ajTCKMOItE4UNd529OtonLbOjcxs8i05sPxffTKXQXL2i5ASwvwe
jJ4d5s5fhERlUM4YXbeA468sqCJlT+/eP4KlePAOQsc1IsY91RmycH+o0Z/yFG0b
JiEb8I8GeiYY+qzDdtPBYFtLkWY12civqucXTwY7F8ykKVfKG8/kTJfIi8R4FUsA
YqxdkuGRxjI2VHDW4Q3q
=SBDv
-----END PGP SIGNATURE-----

--nextPart2648178.4lm86R6J1I--
