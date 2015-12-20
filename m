Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D0C21A170E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 18:16:26 +1100 (AEDT)
Received: by mail-ig0-x236.google.com with SMTP id to4so18613842igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2015 23:16:26 -0800 (PST)
Date: Sun, 20 Dec 2015 15:15:46 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
Message-ID: <20151220071546.GA1270@fixme-laptop.cn.ibm.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <20151218171250.GE17386@linux-uzut.site>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <20151218171250.GE17386@linux-uzut.site>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 18, 2015 at 09:12:50AM -0800, Davidlohr Bueso wrote:
> I've left this series testing overnight on a power7 box and so far so good,
> nothing has broken.

Davidlohr, thank you for your testing!

Regards,
Boqun

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWdlWdAAoJEEl56MO1B/q4ybwH/3OBKVidEOyXPWgIop2x7DnJ
j+nH9UlhiOY/JoN1XdUc/Wk3f7C4zp3zWKC4BdGU7ncznUA5tZe6bD24hgxUtzIi
bVv5ajmy6BEYTWTy39zSlS/7rdD8dolZMyvZONme4QFE5A5gJGDMm4xAYiW8mRyg
Zg0xpN8fyBAfFRS3B9cY2S6YU7mTkSzBqEdWsvpL8XAjaIR4ZDMOLEj+HriwIIQk
z0IyD+omYBPvPK/+vg4dPGZC+a0X/QP37B7vPbBrT7qY9OfcNQhtLTvrWPMiA62Y
315FpeVZW6FsYlv2D9GYZNrwNIquxpjvvVtYA8XEJMkMs81hl57s0gzfkbG3jXI=
=OmNM
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
