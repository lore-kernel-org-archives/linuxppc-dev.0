Date: Mon, 24 Jul 2000 08:19:59 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
Message-ID: <20000724081959.B263@mclx.com>
References: <Pine.LNX.4.10.10007221608490.430-100000@cassiopeia.home> <3979E3BB.1B23FE2@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
In-Reply-To: <3979E3BB.1B23FE2@wanadoo.fr>; from costabel@wanadoo.fr on Sat, Jul 22, 2000 at 08:11:07PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2000 at 08:11:07PM +0200, Martin Costabel wrote:
> There *are* situations where you need /usr/src/linux to point to your
> current kernel sources. This is when you compile modules for the current
> kernel, a prominent example being MOL.

Actually, I prefer to add a -I/path/to/kernel/include to the module
makefiles rather than the /usr/src/linux symlink. I suppose it's
personal preference, but I find that having to explicitly specify
where the kernel source is reduces the posibility of a screwed
compile.

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature
Content-Disposition: inline


--dc+cDN39EJAMEtIO--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
