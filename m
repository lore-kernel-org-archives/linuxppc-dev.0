Date: Mon, 23 Oct 2000 12:27:16 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: gpm and XF401 (Re: ADB-Mouse)
Message-ID: <20001023122716.D426@missioncriticallinux.com>
References: <200010210500.AAA23065@lists.linuxppc.org> <39F4351D.646B972F@physik.uni-marburg.de> <20001023150002.A3112@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
In-Reply-To: <20001023150002.A3112@suse.de>; from olh@suse.de on Mon, Oct 23, 2000 at 03:00:02PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2000 at 03:00:02PM +0200, Olaf Hering wrote:
> You mean you mark some text at console with gpm and all you get in the
> selected area is garbage, even with a non psaux device?
> I tried it here on a chrp machine and got the same effect, could be a
> framebuffer bug. Anyone else with that problem?
>=20
> I have XF4 here with kernel 2.4 and no problems at all (fbdev driver).

I have the same problem on a g4 (r128 fb driver) when using 2.4.

I haven't had the time to look into it, but selecting text in console
mode is definately broken.  It looks like it's somehow using the wrong
characters for the highlighted versions of the text.

Anyone have any ideas,

--=20
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature
Content-Disposition: inline


--GpGaEY17fSl8rd50--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
