Message-ID: <B171A2EF290DD4118E510010B502900680221C@feriex.feri.de>
From: "Halfmann, Klaus" <klaus.halfmann@feri.de>
To: linuxppc-dev@lists.linuxppc.org
Cc: "'Bill Fink'" <billfink@capu.net>
Subject: RE: Hang Mounting HFS CDROM with 2.4.3 final kernel
Date: Wed, 4 Apr 2001 09:36:24 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Bill,

You wrote
> With a BenH 2.4.3 final kernel, if I do:
>
> 	mount -t hfs /dev/cdrom /mnt
>
> the system locks up solid (mouse stops moving and can't switch to
> a virtual console) with no error messages (I also tried it from a
> virtual console but no error messages there either).  The only
> recourse is to hit the reset button to power cycle the machine.
> This is using the built-in DVD ROM drive on a dual G4 (but only
> running a UP kernel).  I can mount an HFS disk without any problem.
>
> This isn't actually a major issue to me personally (at least at
> the moment), but I thought I should go ahead and report it.  I
> discovered it because I was trying to get the MacOS ROM file from
> my MacOS 9.0.4 CDROM for use with MOL.
>

As far as I know nobody really cares about HFS and Linux
(well you should crosspost this to linux-fs-devl, but I dont have
 a correct address at hand) So I try to care a bit ...

What sort of disk is it ? HFS / HFS+ / Hybrid / MultiSession / DVD ?
In case it is HFS+, Linux will only be able to mount the HFS-Wrapper.
You should try my HFS+-utils to acces that CD, then.

Can you create an image from the disk (with dd) and does it show the
same problems ? (Id like to get that image, but I fear it may be to
large for a reasonable download/test. I only have an iBook :/ )

Greetings,
	Klaus Halfmann
	http://www.penguinppc.org/~hasi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
