Date: Wed, 17 Oct 2001 22:02:18 -0400 (EDT)
From: Andrew P McPherson <apm@MIT.EDU>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Compiling BootX?
In-Reply-To: <20011016004536.66a97985.toe@unlserve.unl.edu>
Message-ID: <Pine.GSO.4.30L.0110172159300.16073-100000@biohazard-cafe.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Oct 2001, Takashi Oe wrote:

> On Sun, 14 Oct 2001 23:57:39 -0400 (EDT), Andrew P McPherson wrote:
>
>
> > The problem with the MkLinux booter is that it refuses to run because it
> > doesn't recognize the machine as "supported."  Is the source of the
> > MkLinux booter available so that I could disable that "feature," or was
> > that a closed-source effort by Apple?
>
> It's a closed-source software.  Is the one you have version 1.4?
> What's the gestalt id of your machine with PPC card?  Have you tried
> some software to fake the id (and change the type of apple booter from
> 'scri' to 'INIT' or so)?
>

Thanks for the suggestion.  Installing the "Wish" extension to change the
gestalt ID to a PowerMac 6100/60 worked.  I did need  to change the type
to INIT because otherwise the booter always loaded before Wish.

So now it proceeds to "booting system..." at which point it hangs with no
visible artifacts on the screen.  While I don't expect it to work without
kernel changes, the problem here is that I don't have any way of knowing
whether it booted as far as the kernel or died in the MkLinux booter.
I'll see if anything comes out the serial port, but I doubt it.

Any ideas on how I might find out?  At least with BootX I could enable
debugging messages.

Thanks,

-Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
