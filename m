Date: Tue, 17 Jul 2001 13:15:57 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Armando Di Cianno <diciaa@rpi.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.7preX - unresolved symbols/compilation problem
Message-ID: <20010717131557.H22214@localhost.localdomain>
References: <20010717091235.G29799@garmonbozia.productivitynet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
In-Reply-To: <20010717091235.G29799@garmonbozia.productivitynet.com>; from diciaa@rpi.edu on Tue, Jul 17, 2001 at 09:12:35AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Armando Di Cianno spake unto us the following wisdom:
> I started with an ultra-basic install of YellowDog 2.0 on my TiBook (I
> wanted the glibc 2.2, and I like compiling everything else by hand).
> However, now that everything is up to par, I tried compiling both the benh
> and bk 2.4.7preX trees, and while they compile, upon reboot, all modules
> complain about unresolved symbols, even though cat'ng System.map reveals
> that those symbols are there (stuff like printk!!!).

I had this problem, too, when I just updated and then 'make oldconfig;
make dep vmlinux...'d it.  However, a 'make distclean' and then
reconfiguring fixed it for me.
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature
Content-Disposition: inline


--LQAwcd5tHl0Qlnzi--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
