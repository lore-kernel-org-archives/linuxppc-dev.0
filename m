To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Does a Cinema Display work under Linux?
References: <Pine.LNX.3.96.1000503111322.24757M-100000@deepspace.mklinux.org>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 07 May 2000 18:01:25 +0200
In-Reply-To: "David A. Gatwood"'s message of Wed, 3 May 2000 11:14:25 -0700 (PDT)
Message-ID: <8x4s8a1h9m.fsf@s61.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David A. Gatwood" <dgatwood@deepspace.mklinux.org> writes:

>
> On 3 May 2000, Holger Bettag wrote:
>

[...]

> > > I've been doing it w/ the no video drivers setting and Xpmac.
> > > Obviously,
> > > you're limited with whatever res you were in with MacOS, but that's not
> > > _that_ big a problem, since at least the studio displays only offer one
> > > resolution. I would expect the Cinema displays to be similar, but I'm not
> > > sure.
> > >
> > And are you or aren't you booting with BootX? (Just to make sure.)
>
> Yes.  No problem whatsoever.  Running either 9.0, 9.0.1, or 9.0.2, I
> forget.
>
My G4 and the Cinema Display finally arrived. Needless to say, nothing works
as of yet. :-)

I didn't even try to install Linux while the CinDis was connected; instead
I hooked the G4 to an analog monitor. To my surprise, I got stuck much earlier
than I had expected...

To all who can help:

I managed to install and run Linux on a Sawtooth G4 at work, and I followed
exactly the same procedures with my own G4: got the LinuxPPC2000 install
image, extracted kernel and ramdisk, and installed yaboot with an appropriate
config file.

Yaboot loads kernel and ramdisk, then starts the kernel. Nearly the complete
boot process seems to work. The kernel recognizes and initialiyes all hardware.
However, when the install script takes over, it's unable to reconize any
partitions and thus doesn't get to mount the live filesystem.

(The error messages are somewhat cryptic, referring to devices with hex
numbers like "3:0c" and the like.
  For comparison: the G4 that does run Linux also spits out two such errors,
but then it finds the live file system and brings up the graphical
installer.)

Afterwards, the good old RedHat (console) installer is fired up, but of
course I cannot install anything, because neither source nor destination
partitions have been mounted. When I'm prompted for partitions, the
respective lists are empty, and the installer eventually core dumps. Then
the machine is automatically rebooted.

A quick scan on comp.os.linux.powerpc revealed that some more people seem to
have exactly the same difficulties, and none of them could offer a solution.

I have tried different kernel versions, including the latest from BenH. I
also experimented with versions 0.5 and 0.6 of yaboot, but to no avail.

My G4 runs 9.0.2, just like the G4 at work (although the machine at work
runs a German version, while I ordered and got an English version.)

Does anybody know what is happening here?

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
