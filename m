Mime-Version: 1.0
Message-Id: <v04220807b4c59814d52f@[192.168.1.5]>
In-Reply-To: <v04220803b4c59205ed9e@[10.0.0.42]>
References: <87d7q943zc.fsf@hades.nocrew.org>
 <v04220803b4c59205ed9e@[10.0.0.42]>
Date: Tue, 8 Feb 2000 03:59:14 -0600
To: "Timothy A. Seufert" <tas@mindspring.com>
From: Justin Shore <listuser@vinnie.ksu.ksu.edu>
Subject: Re: adaptec 2940
Cc: Stefan Berndtsson <stefan@nocrew.org>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:38 AM -0800 2/8/00, Timothy A. Seufert wrote:
>At 1:00 PM +0100 2/7/00, Stefan Berndtsson wrote:
>>If I buy a normal adaptec 2940, with x86-bios, will that be found
>>on a b&w g3 and usable in linux?
>
>Probably yes, as long as the aic7xxx driver (generic driver for
>almost all Adaptec cards) is compiled into the kernel.  I think most
>current 2.2.x precompiled kernels have this driver, so it should work
>without any trouble.
>
>>I assume it won't be bootable, due to x86 bios,
>
>Correct.
>
>>  but if it's
>>usable as a dumb scsi-card, that's good enough for me.
>
>If it's a 2940UW, rather than a plain 2940, you may actually be able
>to re-flash the card with the current Mac firmware (version 4.1),
>which is available for download from Adaptec.  Then you'd be fully
>bootable through either MacOS or OF (versions 4.0 onward have OF
>support, earlier versions did not).  The one issue is that not all
>2940UW cards are created completely equal; some of the OEM versions
>for PCs ship with a smaller flash ROM than the name-brand Adaptec
>cards and the Mac/UNIX versions.  It at least used to be the case
>that the Mac firmware absolutely required the larger flash ROM,
>though I've heard that 4.x can fit in the smaller flash.  If you get
>a 2940UW it's worth a shot.  The firmware might even work with a
>plain 2940.

It might be possible to flash some of the OEMs from the MacOS (or
maybe a different revision of the card) but unfortunately it didn't
work for me.  I tried that with a 2940UW I borrowed from work (meant
for PC) and tried to flash it in the MacOS.  It started to and then
died.  I tried it a couple of times.  I gave up and bought a 2940U2W
for Mac (excellent card!  I just wish they weren't sooo expensive).
It worked like a champ with the stock kernel.  MacOS X Server didn't
like it much though.  Oh well.

>(If you need to convert the card back later, you can always plug it
>into a PC and run the PC flasher.)
>

When I took the card back to work and they tried to use it, it failed
horribly.  It printed assorted junk to the screen and couldn't be
found at all.  I tipped off the guy using it (he didn't know that I
he tried to flash it on a Mac) that he should reflash it.  That fixed
it.  I'm not garunteeing that it will work for you too but it did for
me. :-)

Good luck and let me know how it works for you!
  Justin


--
Justin Shore
K-State Linux Distro Mirror, Sysadmin
macdaddy@vinnie.ksu.ksu.edu
<http://vinnie.ksu.ksu.edu/mirror/rpm2html>
<ftp://vinnie.ksu.ksu.edu/pub/mirror/linux>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
