Date: Fri, 10 Nov 2000 19:36:39 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: booting with quik off hard disk on 7220
Message-ID: <20001110193639.T4577@plato.local.lan>
References: <20001111134337.A4931@wibble.net> <20001110180924.Q4577@plato.local.lan> <20001111152702.A5146@wibble.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGopQmzlzQgFk3Fg"
In-Reply-To: <20001111152702.A5146@wibble.net>; from sjh@svana.org on Sat, Nov 11, 2000 at 03:27:02PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--bGopQmzlzQgFk3Fg
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2000 at 03:27:02PM +1100, Steven Hanley wrote:
> On Fri, Nov 10, 2000 at 06:09:24PM -0900, Ethan Benson wrote:
> > > nvsetenv boot-file ' /boot/vmlinux-2.2.17 root=3D/dev/hda6'
> >=20
> > this is redunant, when you have a proper quik.conf you don't need the
> > boot-file variable, in fact it seems to bork things up in my
> > experience helping someone with a 7200.  i would null out the
> > boot-file variable.
>=20
> hmm so what should be in quik.conf instead? With my current quik.conf if I
> dont have that variable set quik stops on the grey screen where the boot:
> prompt is and asks me to enter a [device:][partno]/path which if I enter
> device and boot-file vairable settings in will then boot into the blank
> screen with no hard disk activity just like it does now.

odd that doesn't happen on my friend's 7200, maybe try adding device=3D
to quik.conf with the correct OF device (but not the image name)=20

device=3Data/ata@0:0 or something like that.=20

> yeah happy to give you shell access to the machine as soon as I have debi=
an
> installed and working, I can take the computer and put it online somewhere
> for a while.

cool, let me know when you have time.

> oh well the grey screen with the second stage boot loader and the
> boot: prompt for quik, this doesnt show up unless I set the output device,
> the computer on power on or reboot without setting theoutput device after=
 I
> have done a command option p r just sits there with a black screen and no
> disk activity (kind of like I am either in OF or have gotten past the quik
> boot: prompt and have that blank screen there.)

ah i see, interesting, sounds like quik has its own minimal video
driver, this way OF itself won't show up since it has no driver, but
quik will since it has its own.  nifty.

> oh good, when I still had macos on the machine I thought it was probably
> safer to leave it there, but now I dnt need bootx I wont need them anymore
> either it seems :)

yup ;)

> hmm, okay well I just tried a 2.2.18pre18 kernel I had compiled (that wor=
ked
> on the machine with bootx) rsynced from paulus' stable tree a few days ago
> and it also gave me a black screen and no disk activity.

a serial terminal might help here, some OpenFirmware messages are
usually printed but you can't see them unless you have  serial term.
whether they are helpful or not i don't know.  a kernel hacker could
help you better there.=20

> I will try to track down a tarball of 2.2.10 (I believe there is still one
> on ftp.linuxcare.com.au) and try it next and home it works. Will also try
> the changing of the partition labels to swap and root.

try a 2.2.14 too.  though 2.2.17 was the first since .14 that worked
fine on my friend's 7200.

> hmm I dont have another mac around, I am wondering what sort of cables I
> have to go to a cable place and ask for to have one I can hook up to a nu=
ll
> modem cable or something and speak to minicom on an x86 box.

i think mac serial ports are identical to x86 serial ports, they just
use a different type of plug, i think there are converters for mac->standard

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--bGopQmzlzQgFk3Fg
Content-Type: application/pgp-signature


--bGopQmzlzQgFk3Fg--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
