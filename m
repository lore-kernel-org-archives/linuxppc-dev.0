Date: Tue, 21 Aug 2001 09:29:44 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Bastien Nocera <hadess@hadess.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mixer support on the iBook2
Message-ID: <20010821092944.G20089@localhost.localdomain>
References: <20010821084054.C20089@localhost.localdomain> <3B82602B.1010406@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
In-Reply-To: <3B82602B.1010406@hadess.net>; from hadess@hadess.net on Tue, Aug 21, 2001 at 02:20:43PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bastien Nocera spake unto us the following wisdom:
> Ethan Blanton wrote:
> > I have gotten the sound on my iBook2 working (via the files on
> > http:/www.hadess.net/files/ppc/ibook2/), and I have some questions...
>=20
> Please use the dmasound.tar.gz , it's a better driver (anton2 on=20
> #mklinux fixed that 8 days ago), and I'm supposed to clean it up for=20
> integration in BenH's tree (if he and Iain think that it's clean=20
> enough). Or maybe Olaf will just be sick of waiting and do it himself ;)

That's what I'm using.  It works beautifully (thanks!), but the volume
control is too coarse-grained to be useful for much...

> > In any mixer program I can find, the volume steps on the iBook2 are
> > simply too large.  The sound card goes from muted to too loud to use
> > through earphones in one step of the slider.  Is this a limitation of
> > the hardware, the driver architecture, or what?  Or is it too early to
> > be asking?  ;-)
>=20
> The driver...

To clear up some confusion I have here ...  Are you saying it's a
limitation of the driver (in which case I'm more than happy to wait
for it to be fixed as I know *nothing* about DSP or sound hardware) or
that I need to snag the driver?
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature
Content-Disposition: inline


--FwyhczKCDPOVeYh6--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
