Date: Thu, 20 Jul 2000 11:44:23 -0400
From: Josh Huber <huber@mclx.com>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
Message-ID: <20000720114423.A20249@mclx.com>
References: <200007201345.OAA29151@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
In-Reply-To: <200007201345.OAA29151@hyperion.valhalla.net>; from iain@sandoe.co.uk on Thu, Jul 20, 2000 at 02:45:56PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2000 at 02:45:56PM +0100, Iain Sandoe wrote:
> I guess I *must* have one of those broken derivatives... and it doesn't w=
ork
> for me without that step...  Admittedly, this is mostly an issue between
> 2.2.xx and 2.4.0 - but I do have to remember to change it back between
> whiles... a better way would be ?

Well...hmm, what doesn't work?  You mean you can't build a kernel
unless you make /usr/src/linux point to the kernel source you're
building?  This is odd, as I haven't done that...ever!  In fact,
there's no directories in /usr/src on my machine.

I'm confused, as I've built many kernels on a redhat box here (intel,
but that shouldn't matter) without every updating the symlink, or
using /usr/src to build inside.

I tend to have very large amounts of kernel source laying around, and
I don't like to clutter my /usr partition with them...

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline


--9jxsPFA5p3P2qPhR--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
