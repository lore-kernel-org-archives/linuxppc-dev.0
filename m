Mime-Version: 1.0
Message-Id: <v04220803b4c59205ed9e@[10.0.0.42]>
In-Reply-To: <87d7q943zc.fsf@hades.nocrew.org>
References: <87d7q943zc.fsf@hades.nocrew.org>
Date: Tue, 8 Feb 2000 01:38:16 -0800
To: Stefan Berndtsson <stefan@nocrew.org>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: adaptec 2940
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:00 PM +0100 2/7/00, Stefan Berndtsson wrote:
>If I buy a normal adaptec 2940, with x86-bios, will that be found
>on a b&w g3 and usable in linux?

Probably yes, as long as the aic7xxx driver (generic driver for
almost all Adaptec cards) is compiled into the kernel.  I think most
current 2.2.x precompiled kernels have this driver, so it should work
without any trouble.

>I assume it won't be bootable, due to x86 bios,

Correct.

>  but if it's
>usable as a dumb scsi-card, that's good enough for me.

If it's a 2940UW, rather than a plain 2940, you may actually be able
to re-flash the card with the current Mac firmware (version 4.1),
which is available for download from Adaptec.  Then you'd be fully
bootable through either MacOS or OF (versions 4.0 onward have OF
support, earlier versions did not).  The one issue is that not all
2940UW cards are created completely equal; some of the OEM versions
for PCs ship with a smaller flash ROM than the name-brand Adaptec
cards and the Mac/UNIX versions.  It at least used to be the case
that the Mac firmware absolutely required the larger flash ROM,
though I've heard that 4.x can fit in the smaller flash.  If you get
a 2940UW it's worth a shot.  The firmware might even work with a
plain 2940.

(If you need to convert the card back later, you can always plug it
into a PC and run the PC flasher.)

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
