Date: Wed, 20 Dec 2000 08:18:57 -0500
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ethernet issue with lombard
Message-ID: <20001220081857.A12174@missioncriticallinux.com>
References: <20001220053326.15976.qmail@ww184.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <20001220053326.15976.qmail@ww184.netaddress.usa.net>; from ultrapenguin@netscape.net on Tue, Dec 19, 2000 at 11:33:26PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2000 at 11:33:26PM -0600, jeramy b smith wrote:
>=20
> Me too. There are 3 new lines in the bmac driver that are in the
> dbdma_reset .  Ben added them because what they do is also done in
> darwin. I haven't had a chance to downgrade my driver and try
> though. Running in 100tx mode I have seen it happen whil my
> bandwidth utilization was very low. I was actually actively
> communication each time it got 'gummed up.'

Actually, with 2.2.18, I've had random network lockups as well when
running in 100tx mode.

For a while I thought it only happened in 100 tx, but it just happened
in 10 randomly, so I tried to trigger it with ping -f.  Locks up the
network in a matter of 20 seconds usually.

I've downloaded the darwin driver source, and I've been comparing --
but...why do they have to use C++!?!?  oh well :)

ttyl,

--=20
Josh Huber
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline


--EVF5PPMfhYS0aIcm--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
