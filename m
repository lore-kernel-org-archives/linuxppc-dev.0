Message-ID: <369F5EB6.E34F17E8@mucmot.muenchen.europe.mcd.mot.com>
Date: Fri, 15 Jan 1999 16:28:55 +0100
From: Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>
MIME-Version: 1.0
To: Michael Meissner <meissner@cygnus.com>
CC: Cort Dougan <cort@persephone.cs.nmt.edu>, linux-kernel@vger.rutgers.edu,
        linuxppc-dev@lists.linuxppc.org, gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
References: <Pine.LNX.3.96.990113130844.3715A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:
> 
> It looks like your zImage is being stomped on before it can be
> decompressed.  I'll take a look at the boot loader code and see why it
> isn't adjusting your free ram section.  You might want to try changing to
> load address in the PPCBug to be near the top of memory in the mean time.
I guess this system is running "PowerPC Open Firmware". You can change the
load address via the firmware menu:
  Administrative Options...
    ---> Modify the Configuration Settings...
          ---> Edit Configuration Variables
step to the parameter "load-base" and enter a new value (decimal).
One other problem is the this firmware version obviously does not provide
residual data. So Linux will probably not find the PCI devices correctly.

> 
> }       loaded at:     00400400 00415FD0
> }       relocated to:  00600000 00615BD0
> }       zimage at:     0040A400 0049A889
> }       avail ram:     00400000 00600000
> }
> }       Linux/PPC load: console=tty0 console=ttyS0,9600n8 root=/dev/sda2 mem=127M
> }       Uncompressing Linux...done.
> }       Now booting the kernel

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
