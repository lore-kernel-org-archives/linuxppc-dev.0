From: nyet@nbase.com (Nye Liu)
Message-Id: <199906242015.NAA28109@beavis.nbase.com>
Subject: 8240 Sandpoint
To: doyle@primenet.com
Date: Thu, 24 Jun 1999 13:15:16 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org, nyet@internal.nbase.com (Nye Liu, x248, )
In-Reply-To: <199906242009.NAA28078@beavis.nbase.com> from "Nye Liu" at Jun 24, 99 01:09:45 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I have just started work on the MPC8240 Sandpoint platform (its
> > basically an 603e with some integrated peripherals) but this is my first
> > try at embedded linux devel. I have plenty of experience getting psos
> > and vxworks running on a few different processors, but I am unfamiliar
> > with the internals of how linux is booted.
> 
> I've got one too.  I'm a newbie with the ppc so this is my platform to
> learn things.  I've mostly got a working VGA display configured and
> running...

Could you send me patches vs. a known kernel tarball, or a link to the
changes you made? Also, what kind of VGA card are you using? I can't
even get my board booted.

> > I'm using ESTC's cheapo visionICE emulator solution, and would
> > appriciate any help with getting this thing up and running.
> 
> The jury is still out on the ESTC emulator...

I can get it to load kernels to RAM and to FLASH, but I have yet
to build a kernel that doesn't go off into space and crash the board.

>  Dink does all that for you.  How 'bout booting linux from dink
>  until linux is running?  Then go back remove dink and fix the
>  startup stuff.

I tried loading via DINK... same thing as above. I really think I dont
have a good build yet ;) Also, its TERRIBLY slow compared to the ESTC
loader (since its serial only).

>  I couldn't find docs on National's website for the '87308 but I was
>  able to get the floppy going by just reading the dink code.  Anybody
>  know where to get docs?

UGH. i was looking for this too: no luck. I will contact mot as well and
see if i cant get some docs from our FAE.

>  I was considering patching dink to add a command that would copy a
>  floppy into memory.  That might ease hacking.

Yes yes that would be a nice feature.

Nye Liu
nyet@nbase.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
