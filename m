Date: Tue, 21 Aug 2001 08:40:54 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Mixer support on the iBook2
Message-ID: <20010821084054.C20089@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,
I have gotten the sound on my iBook2 working (via the files on
http:/www.hadess.net/files/ppc/ibook2/), and I have some questions...

I know there has been some discussion on this list that the OSS mixer
semantics are insufficient for the PPC sound architecture in modern
Macs.  I don't know if this is related or not...

In any mixer program I can find, the volume steps on the iBook2 are
simply too large.  The sound card goes from muted to too loud to use
through earphones in one step of the slider.  Is this a limitation of
the hardware, the driver architecture, or what?  Or is it too early to
be asking?  ;-)
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature
Content-Disposition: inline


--zCKi3GIZzVBPywwA--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
