Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCK4M6VxxzDvQv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 04:21:55 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: Michael Ellerman <mpe@ellerman.id.au>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Petr
 Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
Date: Mon, 7 Nov 2016 17:21:49 +0000
Message-ID: <2028257.UuvQgdciME@np-p-burton>
In-Reply-To: <4f990791-ebff-dbe3-b923-3cac5fd6f97d@lwfinger.net>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <13471233.iqSeGS5aQ3@np-p-burton>
 <4f990791-ebff-dbe3-b923-3cac5fd6f97d@lwfinger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8065770.dtbUVlAn7e";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart8065770.dtbUVlAn7e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Larry,

On Monday, 7 November 2016 09:26:37 GMT Larry Finger wrote:
> > A revert was already submitted by Hans de Goede & is being discussed over
> > here:
> > 
> > https://marc.info/?l=linux-kernel&m=147826151427455&w=2
> 
> I am a little surprised that I was not CCd on that thread.

Hans started that thread without copying you just as you started your thread 
without copying Andreas, who reported issues first.

> To reiterate, my
> PowerBook G4 with a PPC32 processor CRASHES on boot. That is a lot more
> serious than the console output disappearing.

Crashes as in init dies due to lack of a console, right?

> As it seems unlikely that this regression will be fixed in the current
> cycle, I recommend that the reversion of commit 05fd007e4629 until a proper
> fix is available.

I agree that reverting is probably the best option for now, and have replied 
with that in the other thread too.

Thanks,
    Paul
--nextPart8065770.dtbUVlAn7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYILgtAAoJEIIg2fppPBxl1xYQAIWQsPOnvvieDOy1SmyWR0rl
hoVMhM4M4G02BUABaqDcw6ql9panJY4v2oXuXqvu/HRY5q3JdtYUBXyrzAmzA+PT
RpEqvanOho1F1MUBIZMYUr0qxPANdblHxQ1cnZHKI6PBlfDqZQYF5qx6cMlvtXRJ
FumVl/FtZlzMDY2cOL5j1HPT6KGOvX+vl8jQe6fzgSOcfENYhsKm4SSdNC04L+Tc
eHRMBJE5aQnpopypCZxx8VupCyeXsxQoPoRWS8WePLzTnNfKsAaGgiAgBI8wKLBF
+p25p8NVTpFYPRzPU4ESjqRpc11TcVrL52QKumI721/1tEccsSlofqCdLg9v/vhX
5aU41NgpYeEcoEE0kS1VNEtZ2kz/GAVWYaAU8yUS5sa22Ty88mbHkQyVbTUKJEtl
1Fkew/QWo4fZAPhcQuUdo9fP68LGKndNF6E2Z3NA+PY8eecNwy57qeb8bq5HWmGR
fTcIPzUv5PdrA1Fh3xLOM5rdu5W96bjjaiz2H7i77NnrE02ntX3QR5GSBZ0gCn70
YgKmRf9nI+w3vnL3srvm9gSUN0Vs0kQLtXO8udsBVuLi2QENQtDm8C8uU6obfR1q
WzuXY1OAmMJJSMa1kPmoBggu3W0LR828wziUqdeyPrGIolSuYztWLDNZnGpurNlB
TOA6p5aXMGe7nxcbwTtf
=pMKl
-----END PGP SIGNATURE-----

--nextPart8065770.dtbUVlAn7e--
