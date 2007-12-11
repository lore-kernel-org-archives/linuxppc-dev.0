Return-Path: <michael@ellerman.id.au>
Subject: Re: initrd - console
From: Michael Ellerman <michael@ellerman.id.au>
To: Siva Prasad <sprasad@bivio.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A7AFE@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A7AFE@corpexc01.corp.networkrobots.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-omhCTANoi/tiCq0fvJvC"
Date: Tue, 11 Dec 2007 12:34:20 +1100
Message-Id: <1197336860.7378.29.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-omhCTANoi/tiCq0fvJvC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-12-10 at 17:26 -0800, Siva Prasad wrote:
> Hi,
>=20
> I am trying to boot kernel with initrd. However, it hangs in
> run_init_process("/sbin/init"). I went into the system calls to see what
> it is doing.=20
>=20
> As part of debugging, I ended up adding a printk statement in
> arch/powerpc/kernel/process.c:sys_execve() routine. Noticed that all the
> calls are coming here, however nothing is printed on the screen. I think
> initrd is executing fine (unless one of you says otherwise). See the
> capture below for boot log.
>=20
> Question 1: how come nothing is printed from ramdisk (userland programs)
> to the serial console, while all the kernel printk's are working
> perfectly?

Do you have a /dev/console etc. in your initrd?

> Question 2: How important is to have interrupts working for just
> printing. I know that interrupts are must to enter input.

Depends on what your console is, but if it's something simple then you
should be able to write to it without taking interrupts.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-omhCTANoi/tiCq0fvJvC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXekcdSjSd0sB4dIRAulVAKCyatMeFaQqlmZWOJMzSGjICbo5wACgsbf+
nqjpGMDHdsSiB/Z28fRewrM=
=mI4C
-----END PGP SIGNATURE-----

--=-omhCTANoi/tiCq0fvJvC--
