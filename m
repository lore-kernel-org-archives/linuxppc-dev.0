Date: Mon, 25 Sep 2000 21:22:55 -0800
From: Ethan Benson <erbenson@alaska.net>
To: johnathan spectre <jspectre@lords.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ybin, nvsetenv and MacOS X
Message-ID: <20000925212255.O1928@plato.local.lan>
References: <B5F51108.2280%jspectre@lords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
In-Reply-To: <B5F51108.2280%jspectre@lords.com>; from jspectre@lords.com on Mon, Sep 25, 2000 at 02:26:17PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2000 at 02:26:17PM -0400, johnathan spectre wrote:
>=20
> After an install of ybin (I've reinstalled it a few times) selecting "x"
> will result in some disk activity the first time I press "x". Then return=
 me
> to ybin's boot menu.

this means that the command to boot MacOSX failed, when something in
my menu fails OpenFirmware simply reloads it silently.  (not terribly
intuitive i know, im not sure what i can really do about it..)

> Pressing "x" every time after boots me into my MacOS 9 partition as if I
> pressed "m" or let the system boot to default (it doesn't cycle after that
> first time).

eventually i think mac-boot (the default OF boot command) will tire of
reloading my script and just look for some other partition to boot.
thats probably whats happening here.

> I'm wondering if ybin hasn't been updated to MacOS X Beta yet or is
> something wrong? OS X is installed on partition 16 on my system and boots
> fine if I use Apple's boot disk app to set it as the boot volume.

well since i don't have access to OSX i am just guessing as to how to
boot it.  i am making the assumption that it boots the same way as OS9
(which from what people have told me is true)  i execute the command:
boot XX:Y,\\:tbxi where XX is the OpenFirmware path to whatever device
you specified, and Y is the partition you specify.  ie: hd:16,\\:tbxi=20

this SHOULD work assuming apple has a blessed directory on the
partition you specify and a file with type tbxi located there.  this
is what is done in HFS+ setups as i understand and what you have on
the OSX bootstrap partition for UFS setups.  keep in mind that for a
UFS setup you need to specify the OSX bootstrap partiiton and not the
OSX root partition.  for HFS+ setups i asume the OSX root partition is
correct.=20

> Additionally, I tried "boot hd:16,\\:tbxi" which is what I thought the bo=
ot
> menu was trying to do. I get an error message and nothing happens (I might
> be wrong though, I'm still learning what these scripts do).

this is the command my menu is executing yes.  can you tell me more
about your OSX install? is it HFS+ or UFS?  also a mac-fdisk -l
/dev/hda would be helpful. =20

another possiblity is you booted OS9 and it mounted your OSX partition
and deblessed it since its not real MacOS....  (this is worse then
win95's installer....)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature


--acOuGx3oQeOcSZJu--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
