Message-ID: <376C01F3.666112C3@primenet.com>
Date: Sat, 19 Jun 1999 20:47:47 +0000
From: Bob Doyle <doyle@primenet.com>
MIME-Version: 1.0
To: Nye Liu <nyet@nbase.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Motorola MPC8240 Sandpoint embedded linux
References: <376AD199.43D25@mrv.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nye Liu wrote:
> 
> I have just started work on the MPC8240 Sandpoint platform (its
> basically an 603e with some integrated peripherals) but this is my first
> try at embedded linux devel. I have plenty of experience getting psos
> and vxworks running on a few different processors, but I am unfamiliar
> with the internals of how linux is booted.

I've got one too.  I'm a newbie with the ppc so this is my platform to
learn things.  I've mostly got a working VGA display configured and
running...

> I'm using ESTC's cheapo visionICE emulator solution, and would
> appriciate any help with getting this thing up and running.

The jury is still out on the ESTC emulator...
 
> The main problems that I see are:
> 
> Its not CHRP or PREP.
> 
> No prom, so i need to:
> Set up the memory map.
> Program the EPIC.

Dink does all that for you.  How 'bout booting linux from dink
until linux is running?  Then go back remove dink and fix the
startup stuff.

> Verify that the current serial drivers work with the Sandpoint's NS
> PC87308.

The code in dink has code to initialize the two serial ports.

If you want to get the floppy, mouse, keyboard, parallel ports, etcs
going you've got to configure the '87308 for that.  It looks like all
you have to do is provide the base addresses for the peripherals
to the '87308.

I couldn't find docs on National's website for the '87308 but I was
able to get the floppy going by just reading the dink code.  Anybody
know where to get docs?

I was considering patching dink to add a command that would copy a
floppy into memory.  That might ease hacking.

> Please email me directly, as I am not subscribed to this list, although
> i do read it regularly on the linuxppc site.
> 
> nyet@nbase.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
