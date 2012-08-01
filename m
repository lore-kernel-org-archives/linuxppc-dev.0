Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 1 Aug 2012 12:02:47 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 3.5+: yaboot, Invalid memory access
Message-ID: <20120801020245.GC6467@thor.bakeyournoodle.com>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
In-Reply-To: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2012 at 10:46:39PM -0700, Christian Kujau wrote:
> Hi,
>=20
> when trying to upgrade from 3.5 (final) to today's git checkout from=20
> Linus' tree, yaboot cannot boot and the following is printed:
>=20
>   [...]
>   returning from prom_init
>   Invalid memory access at %SRR0: 00c62fd4  %SRR1: 00003030
>=20
> The whole message: http://nerdbynature.de/bits/3.5.0/yaboot/
>=20
> The Yaboot version is 1.3.16 (from Debian/testing), I haven't tried 1.3.1=
7=20
> yet, its changelog does not say anything about "newer kernel support" so=
=20
> I'm not sure if this would help here.

Well the "returning from prom_init" message is from the kernel so yaboot
has done something.  We'll work out if it was the right thing ;P

I had a look at the URL you provided.

1) can you also upload you vmlinux so we can poke at it.
2) What is the dmseg.txt file there?  If you're unable to boot 3.5 how
did you get the dmesg?

Yours Tony

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQGI5FAAoJEEsCiJRY75GKUfAP/2PVyAPZakiJHYzX1+NZjUHA
TwymUZjfHRGXMGoPC8MR0rx6ys/zF8xQfmTmukbUBHW0KjFylXsX2r4LmNquT+zB
n/Wrj7P6haCUx56jQxGRisEnlNZCmq1MtlfGbG3TeCIPxC19ek/JUw97Nmblbt3t
hh0LPRjM1IV8ZYJXcrkC4GNNR3/OHXBovMgd58erBeqaXPXz66yPfUlZL2AVEw0F
2InpXOcX/4191pTSvGfFyACzv6oTXCV5bDAQSVn16p8BpPeNgunJEg6FLIPLCQBd
1zTAlYEJLyLZ2lt7j+Jdddn3UE5ntLNMkEiSvTchOIoTs+j943Nu8KXkiG/BHiNe
aiW+KofQvQmzN2LFCNAlkLaqb8XRWs9U/x9Zj4OyjabqYqW9kCcZE7mC33tIYLML
rgB40SvOexElpZL2M6Z5slFeRtTbTcIfMdOOQAJ9RTb0SYbtb5YamJir9jb14qR6
z+ZzZfYtjk9tBdyEBYWiVSP0ucVdO/wRZ6TWeD3/pOAZHaGNHQf/yPpzqbsJrqja
Rh3UwuHEA/GJ6TGPOk/ClbZcxhCMR7fPuCAKyWdFg8UuETZqEJ2gGfrVF1ZDOwMp
hFDVSGSCvLRzGHDULTMYbvzDyOm1yMpm7SaKICLdamWSYiQ0Pg/zwhJszAIv47KC
/YT9ZWMf8AuXi44LOuw2
=wgUf
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
