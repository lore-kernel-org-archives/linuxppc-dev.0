Date: Tue, 16 Mar 1999 20:55:31 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Cort Dougan <cort@ppc.kernel.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new bootloader
Message-ID: <19990316205531.A8459@tiktok.cygnus.com>
References: <Pine.LNX.3.96.990316032305.21674A-100000@persephone.cs.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990316032305.21674A-100000@persephone.cs.nmt.edu>; from Cort Dougan on Tue, Mar 16, 1999 at 03:24:43AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 16, 1999 at 03:24:43AM -0700, Cort Dougan wrote:
> 
> Has anyone tried it yet?  I haven't had any complaints and it's hard to
> believe it works for everyone as it is now.
> 
> If you haven't tried it and were having trouble before please do give it a
> test.  Even if you can't give me patches for your hardware a quick
> description of the problem will help me get things in position to work
> sooner.

I'm not sure whether I have the code or not, but I did take the vger tarball
linux-vger-2.2.2-990307, and built it.  It sort of boots on my Motorola
PowerStack-II NET4000, in that if I'm physically present and type in the
root=/dev/sda2 string at the prompt it will boot, and it won't recongize more
than 32 meg of memory (my machine has 128 meg).  However, the machine mostly
sits in a closet, so I would prefer not to have to do anything to reboot it.
In addition, when the machine wants to reboot, it hangs.  Gary's patches to
2.2.1 solves the first problem via CONFIG_CMDLINE that the user can specify the
initial command line and the second problem by knowing where the OF residual
data is kept, and I never experienced the third problem.

On my other machine, an original PowerStack with a 603 (not 603e) and no cache,
it hangs right after the prompt, just like Gary's patches did (the original
version of the last of the 2.1.xx series booted fine on this machine, but did
not boot on the NET4000).  Note, I didn't have a disk in the machine, but it
didn't get the usual distance going through the boot screens until it actually
touches the disk.

> 

-- 
Michael Meissner, Cygnus Solutions
PO Box 98, Ayer Massachusetts, USA 01432-0098
meissner@cygnus.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
