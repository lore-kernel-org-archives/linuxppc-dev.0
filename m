Return-Path: <sven@narfation.org>
Received: from v3-1039.vlinux.de (narfation.org [79.140.41.39])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 414F31007D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 08:49:24 +1100 (EST)
From: Sven Eckelmann <sven@narfation.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Sun, 04 Dec 2011 22:49:10 +0100
Message-ID: <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
In-Reply-To: <20111204213316.GB14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
 <20111204213316.GB14542@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4938203.Qb6ixptZZ3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergma nn <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>,
 linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart4938203.Qb6ixptZZ3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
[...]
> > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> 
> I think this is rather silly - all these definitions are very similar to
> each other.  Is there really no way to put this into include/linux/atomic.h,
> maybe as something like:
> 
> #ifndef atomic64_dec_not_zero
> #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> #endif
> 
> and avoid having to add essentially the same definition to 12 individual
> files?
> 
> Architectures which want to override it can do by the following:
> 
> #define atomic64_dec_not_zero		atomic64_dec_not_zero
> 
> which won't have any effect on C nor asm code.

 * https://lkml.org/lkml/2011/5/8/15
 * https://lkml.org/lkml/2011/5/8/16
 * https://lkml.org/lkml/2011/5/8/321

Kind regards,
	Sven
--nextPart4938203.Qb6ixptZZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO2+rWAAoJEF2HCgfBJntGGaoP/1cME9u1tSkxi9MYlM/Ss2sw
Du85XnWWOFnV+CRwZ7+QCkgr10dzf/Qf7ekcxzM/7wapAawu0FmBbehfNW+06uW0
4XrIxUDaZy0xgHusju96MVJav0msORD/2RXM3rQxwkjR2FhmfbVntuIu/5EqEHFv
jIzksziGDgrHx6/HMjrEiX8p2tPPBfQ7MGa1Cvj+kLgDhPAPCOUKfpwgdj35MYHe
2D+zXMr6aHi/JtDkYK2BV9u9nAGx91fcPdOO4/SyyxVg4DLrUnuRgWhNF9UCXd7R
IDkz2SAlkqP5RXKa9XMxnS1n1zjkpmc1wfRL4rPHmk7Fg9IgidnlZ8TsXKuDjoVR
JtIuXmj1FQ5nuHnzKnzhIfHMlu395tL0PVHeWi1+dPZGfUCLX+T4jdlTRaShY3d1
UUzpbfKuc2dy8uX5BNfJ5kQl4PSx8w97Kn+8vRbb3U627FIpdkK8RQNEGgB7wpIR
rCqnxvsjPiiyQA9ckXmL/S0d9xlrPcrB1Tu4kUgXYTr6llV/xKWuYtl801IFP6lr
kFqvPd5St69DP66x5bMMC4NalTEfCIx7HOx+xd3xQC+9qsJVLomz95bvMZHxeI8K
Ae736/5KDqONzVPOKW2J+UJIJLqIZPuSbNVRY9lkTZXjii1U25WY03PGAGwa4LLP
mGvc5Y2WUfdr8CtFrvVL
=T3Oo
-----END PGP SIGNATURE-----

--nextPart4938203.Qb6ixptZZ3--
