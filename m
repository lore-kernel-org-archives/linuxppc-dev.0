Date: Tue, 25 Apr 2000 16:13:44 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Ethan Benson <erbenson@alaska.net>,
        Daniel Gonzalez <daniel.gonzalez@pandora.be>,
        LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bye HFS partition?
Message-ID: <20000425161344.B2163@plato.localdomain.local>
References: <390516C2.1DD0D2D@pandora.be> <20000425010826.T7022@plato.localdomain.local> <3905CD51.90ED385B@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
In-Reply-To: <3905CD51.90ED385B@wanadoo.fr>; from costabel@wanadoo.fr on Tue, Apr 25, 2000 at 06:52:33PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2000 at 06:52:33PM +0200, Martin Costabel wrote:

>=20
> I don't think that HFS support is *generally* unreliable. It works well
> with 2.2.x kernels and is broken on recent 2.3.x kernels. From his
> earlier posts I recall that Daniel is using a 2.3.99 kernel.=20

I have heard that it does not cause kernel oopes or panics on 2.2 but
that it still has general flakyness, such as having the entire
contents of the filesystem vanish, though usually the corruption is
not permanent, occasionaly it seems to be.  but your right that its
broken on 2.3 its been that way for a long time presumably because of
the  VFS changes or whatever it was that broke all the filesystems,
HFS the way i understand it has just been patched enough to compile
but not beyond that, from your comments below it seems obvious that
much more work is needed. =20

> For me, mounting an HFS partition under a 2.3.99 kernel and doing more
> than just a file listing leads to almost instant system freeze and
> sometimes destruction of the HFS partition (I am trying this only on a
> ZIP, so I can easily reformat). The oops I get comes, in general, from
> the hfs_bnode_relse function in fs/hfs/bnode.c, where a waitqueue bug is
> detected.

that must be what Alan Cox means by `HFS is broken' in the 2.4 tasklist...

> It would be nice (and rather vital for the survival of LinuxPPC under
> the imminent (?) 2.4 kernel) if some LinuxPPC developers woke up to this
> situation. (Seems to be above my capacities, sorry). The official
> maintainer of the HFS code doesn't do much, and some developers (I
> remember A Joshi and Tom Rini) gave the impression that they have a
> working HFS filesystem under 2.3.x. In the todo list for kernel 2.4,
> however, HFS is marked as broken (but no showstopper for the i386 crowd,
> of course).

well lets face it nobody except PowerMac users care about HFS, the
only OS that uses it only runs on Apple hardware.  there are just many
more interesting things that are more important to most (read teh i386
folks) people then a filesystem most people dont use (meaning most
people don't use Apple hardware) and its been mentioned before that
filesystems are not much fun to work on. =20

its too bad there is no way to have DOS filesystems on apple
partitioned disks (well there is but Macos will refuse to mount it) oh
well there is always hfsutils which seems to work ok.

however, i see HFS+ support as being a worse problem then HFS,
OSX is unlikely to support plain HFS (for any of its main partitions),
does anyone know if one can use UFS/ffs instead of HFS+ on OSX?
read-only UFS support is fine on linux and write support is i think
probably much farther along then HFS+ anything is..


--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkGNLgACgkQJKx7GixEevzdjACfd9qdCF7ronbVgdTdLGdsrKMW
aQ0An38UwJ5jwmH5H/Z5vaPi9lG9X1l1
=YkI+
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
