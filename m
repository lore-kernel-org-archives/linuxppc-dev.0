Date: Tue, 12 Sep 2000 09:30:49 -0400
From: Josh Huber <huber@mclinux.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: strange console behavior in 2.4
Message-ID: <20000912093049.C6709@mclinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been playing with 2.4 on my G4, and everything's working great,
except for text selection in console mode.

If I use gpm to select text in console mode it's almost as if a
completely different (and very wrong) character map is being used.
The characters that have been selected not only invert color, but they
change to different ones.  Most of them look like high ascii chars,
like smilely faces etc.

Anyone else seeing this?  A 2.2 kernel on the same system works great.

btw, I'm running debian potato.
--=20
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature
Content-Disposition: inline


--yLVHuoLXiP9kZBkt--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
