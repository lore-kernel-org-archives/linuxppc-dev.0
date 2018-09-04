Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424Pvx0cfSzF3HH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 21:37:48 +1000 (AEST)
Date: Tue, 4 Sep 2018 13:30:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Henrik Austad <henrik@austad.us>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Karsten Keil <isdn@linux-pingi.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Len Brown <len.brown@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Evgeniy Polyakov <zbr@ioremap.net>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ian Kent <raven@themaw.net>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Jan Kandziora <jjj@gmx.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 kvm@vger.kernel.org, Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Message-ID: <20180904113030.GB25177@amd>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise


> -SAK.txt
> -	- info on Secure Attention Keys.
> -SM501.txt
> -	- Silicon Motion SM501 multimedia companion chip
> -btmrvl.txt
> -	- info on Marvell Bluetooth driver usage.

Well, I don't know what sm501 is, but description helps me. SAK is
similar. .. as is btmrvl.

I'd say this is still quite valueable, and it might be worth fixing,
rather then removing completely.

And yes, moving stuff to subdirectories and naming files reasonably
would help, too. "btmrvl" is really bad name...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluObNYACgkQMOfwapXb+vIEUgCfflpJ++Ke7RojgYEKLcv9wdCK
VcAAoJ44RGl6/ZbjcSM3g58FnjCGx/f+
=c4sE
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
