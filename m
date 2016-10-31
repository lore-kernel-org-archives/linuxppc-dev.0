Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6tnH60h5zDvtt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 23:23:31 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Andreas Schwab
 <schwab@linux-m68k.org>, <larry.finger@lwfinger.net>
CC: Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>, Sergey
 Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 <linuxppc-dev@lists.ozlabs.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>
Subject: Re: [PATCH] console: use first console if stdout-path device doesn't
 appear
Date: Mon, 31 Oct 2016 12:23:21 +0000
Message-ID: <5219732.Ba7sxnzBSd@np-p-burton>
In-Reply-To: <87zill13z8.fsf@concordia.ellerman.id.au>
References: <87oa2ij2mq.fsf@linux-m68k.org> <878tt6np85.fsf@linux-m68k.org>
 <87zill13z8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2321443.CjjFPbxoKL";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart2321443.CjjFPbxoKL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Michael et al,

On Monday, 31 October 2016 16:28:59 GMT Michael Ellerman wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
> > Any news?
> 
> We discovered it also breaks VGA on qemu, which presumably is not the
> type of news you were hoping for.

On the contrary, that's wonderful news - I can test that! Huzzah for 
brokenness!

Thanks for your steps to reproduce the issue. Could you try my v2 patch? It 
works for me in QEMU, at least as far as seeing the kernel console output for 
a panic due to not having a rootfs. Hopefully it works for you (& Andreas & 
Larry) too:

https://patchwork.kernel.org/patch/9405415/

Thanks,
    Paul
--nextPart2321443.CjjFPbxoKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYFze5AAoJEIIg2fppPBxl/YMQAJuxU6hgKgqxQolrOH5g47zn
NqDrVwpoWhN7npuM+pocX3HXRy0eLsJTNwdlYngCPlGk65rHYV/obH90SqA3nOAq
yRoqs4eCD3Dvd6MVbZzacw2HlIyg2PbjUEqlcgqHz95jnTneBQG+MhaKYHSDgJYI
CsBeqcsH3TiT3Oh4oe0vAF3Xi39ieG5TsFC2utACQtf2I8RyZx4YPaBD8/rJAJBA
qwi22PXgQ0BJjfD+K71SYcgZELQqED/mj+CoBbky+qHzFc5E+MZDjRPekY0F3jxO
rlVyFqNsTgYc5uCtJG+xfZx65LyR0H+tQ5FSUv72nNB1uNaNRDpkutkbtPoTidsW
eMyNVKDaz7xQ9UQ7M/MK/HAFCtewqM/8BEBwr/6/tYLGapZCmFCRLYv1vLoL1hxN
QDoCggvXQ/Ju40O/jwFuRbbhodvQfXwhGWt/VOHF2AxpIXzhntnxyX7zYVZrCZN/
tozZkdn2IMv8vOPO/8g3jeG9ZZcw6UscJ129/LLdX1gMiYUkx1hHSlAUEH18P91n
RKvl8kUhHzGXoSGu3p8jFfD6jyRr0eJxBxrNNb+tJWImU+WA2wd7vvLGO/CdLs29
cWk4f9CuXqVZykiNYf+qUrMY+w0jZb3Gk/pFShY3CaIAaUEXZXdH5n9A4YYh1v+a
InRdYEKz59KQV+K/zDFS
=R0N4
-----END PGP SIGNATURE-----

--nextPart2321443.CjjFPbxoKL--
