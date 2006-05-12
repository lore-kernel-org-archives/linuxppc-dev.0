Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A98E7679FC
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 00:27:58 +1000 (EST)
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
From: Johannes Berg <johannes@sipsolutions.net>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060512141918.GA3566@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<20060510213028.GG3878@localhost>  <20060512141918.GA3566@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iRSvI1Ji+gTdMLmKIEmp"
Date: Fri, 12 May 2006 16:27:28 +0200
Message-Id: <1147444048.7404.39.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	Matthias Grimm <matthiasgrimm@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iRSvI1Ji+gTdMLmKIEmp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-12 at 16:19 +0200, Wolfgang Pfeiffer wrote:

> [Oops, something's messed up there: this actually is a 1.67 Ghz
> processor. I'll have a look at this later .. :) ]

No, it's fine, it is clocked down at boot, use cpufreq.

> I filled /etc/modules with snd_aoa modules and i have sound already
> from boot time on ... with a minor glitch (i.e. not being able to
> store a certain volume level via alsactrl to the next reboot, as it
> seems), but sound ...

There are a bunch of userland bugs... Alsamixer cannot cope with the
3..28 of the capture volume, some gnome tools can't cope with the
negative scale of the playback volume, and others.
I don't want to workaround this, please all file bugs against the
respective programs.
amixer always seems to work fine.

> I have problems doing the same with pbbuttonsd. That is I can start,
> e.g., gtkppbuttons, but when pressing <FN>-<F5> or <FN>-<F4> it seems
> being impossible to change the sound volume this way. But I can toggle
> it completely ON/OFF with <FN>-<F3.> ... not being sure tho' whether
> this is due to some of my braindead mistakes or really a pbbuttonsd
> issue ...

No idea, I no longer use pbbuttonsd.

> Thanks again a lot to everyone for your work, your time, and the
> resulting fine software ... :)

:)

johannes

--=-iRSvI1Ji+gTdMLmKIEmp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGSbTaVg1VMiehFYAQIQcg//Wxs3S79snHOWwbXXRqvWm2850BfPPfvu
EgPea0iT9Z3ZuaFqNwVpNWjyIoxJPcunQACWVeR9V9lNltvQm84vrYXh9m+6t8r5
9PMN/yk+3NQ5VJklYWPvAmfeuy8QohAooNuEKUbc9hvBEAME5FrelWIt6XQJxYxK
vyGZuHiCa1/x9zEa8Nu0KSs7A7PoGp6Jas7Soaf9Kwm1FF7yEqw1vm0zg9bWWeyi
oHxLzQVtL7wwA+CQUsoOX3UZox+2aZrAWF2zYGnoUB5bTi5HJFWMX1GgOCqlk93n
fCx3oPKskYOMd+BccjiaO5dKrgfyqluQbg/uBGsWdxPU/y+y1hMH1+wAhooIaOk5
s7za/MKOcEfL91JP5QLCCPEV3CnJTTMpd76S9XbQKiDmNasCDq+ArpnVHQmgnaRy
vWTx+/IZUpKxVSYfk0cPXe2bI+XLc2JBeE3H7bG9SfYpppOjNc38lPNlY9iiiD2d
IW3BF/p1BJEBavOZo1vmx1sXnf9ZCSGfhTpBvr9GhhmvQ46va+VvDlo9+VrVsT9D
9Vbob9SVOlCA/9kMxN6E0rxuD4jsXUpU6b1uZRVBqvDABA+6kLzXySWnEHwQbF7P
jY06yUXwccNLbxgfm0X6yvF573h+DojJSrqncJQzA7WLTRND6ucdb0k5Mgydd7D7
/HXBePR14ZY=
=Fm3O
-----END PGP SIGNATURE-----

--=-iRSvI1Ji+gTdMLmKIEmp--
