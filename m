Date: Sun, 10 Jan 1999 16:46:11 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Dan Malek <dmalek@jlc.net>
cc: Wolfgang Denk <wd@denx.muc.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MBX860: How to boot with initrd ?
In-Reply-To: <36983326.EA43D05F@jlc.net>
Message-ID: <Pine.LNX.4.04.9901101642350.926-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 9 Jan 1999, Dan Malek wrote:

> 
> Wolfgang Denk wrote:
> 
> > ....  But  I  must be missing something, because such an image will
> > not boot; all I see is:
> 
> Hmmm.  I know initrd works because I use it quite often.  All of the
> memory relocation looks OK.  Cort had a good suggestion, can you
> build a kernel that boots using NFS (or at least boots to the point of
> trying to mount the root fs).
> 
> 
> >         Linux/PPC load: console=tty0 console=ttyS0,9600n8
> 
> This looks a little weird.  It should not be necessary and I
> don't know what happens when it is used.

Actually, it's pretty handy, if you have a VGA display.. it will duplicate
everything printed to the console to tty0 (VGA) and ttyS0 (the serial
port).  This is hardcoded in arch/ppc/boot somewhere.

I don't know how much this will help, but I have had some problems with
the bootloader when compiled with some versions of egcs on a Blackhawk
board. You could try compiling arch/ppc/boot/*.c with -O instead of -O2.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
