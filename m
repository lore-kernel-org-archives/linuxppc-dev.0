Date: Wed, 29 Mar 2000 05:05:51 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: Ethan Benson <erbenson@alaska.net>
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000329050551.B27338@plato.localdomain.local>
References: <Pine.GSO.4.05.10003281041030.24048-100000@grad> <38E1AAC1.A8999A9B@ncal.verio.com> <20000329043355.A27338@plato.localdomain.local> <20000329155834.A30559@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <20000329155834.A30559@suse.de>; from olh@suse.de on Wed, Mar 29, 2000 at 03:58:34PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2000 at 03:58:34PM +0200, Olaf Hering wrote:
>=20
> What about different kernel images? 32 MB is a good value.
> And it is more secure, even for older Macs with BootX.=20
> I don't trust the hfs.o=20

kernel images do not belong on this partition, they belong on your
ext2 root filesystem in the /boot directory, this is where yaboot will
load them from.

> There is nothing on that partition that can be screwed up and the user
> can change the yaboot.conf and the os-chooser file from the MacOS side.

yes there is, the blessing WILL get removed by macos, if it has not
happened to you, then your lucky, macos for me NEVER fails to ruin
fake system folders. don't play with fire is my philosophy on this.

> I had never problems with my faked system folder, I move it around, to
> CDs, to netatalk servers and where ever I want. This can be a "feature"
> of OS9 that it doesn't remove the information, I don't know.
>=20
> What makes this blessing so special??

OF will not boot automatically with its default configuration
otherwise.  unless you LIKE screwing with its variables ;-)

> I have the Finder from MiBoot.smi, I changed the type/creator to
> FNDR/MACS. The System is the same from MiBoot, unchanged. There is a
> faked RomFile =3D yaboot and its .conf. Thats all.

miboot has nothing to do with yaboot. creating fake system files
SOMETIMES prevents macos from deblessing, but usually it does not.
(take my word for it i have much experience dealing with fake system
folders like this for other purposes)

also yaboot cannot be given type tbxi because its an ELF executable,
and OF refuses to boot a type tbxi file unless its a CHRP script.
that is why we have to use that wrapper instead.

> You have to move the Finder file out of that folder and move it back
> onto the closed folder icon and it is bootable. All you have to do now
> is to open the control panel Startup volume and you are done.

i have found this is very unreliable and usually does NOT work.  my
method allows for default OF settings with no modification. and
guarenteed access to the boot menu.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjiDb8ACgkQJKx7GixEevwBiACgkcaCKt3JwA3eFGZp/xJRfWNf
ePIAn3y6dPz6xXRnD0NEfeyID3Bpi985
=xiJD
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
