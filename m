Date: Fri, 3 Sep 1999 08:11:42 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB mouse kernel patch for Lombard gpm multiple mice support
Message-ID: <19990903081142.B9794@io.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David King wrote:
> I've been lurking on this list for tips on getting my Lombard to work
> nicely under Linux.  Using the latest stable samba rsync sources I've been 
> able to build a kernel which does accelerated X, ethernet, sleeping, and 
> USB.   The only thing left preventing me from being comfortable was one
> quirk.

I've been working towards a very similar goal (333 MHz Lombard I just
got yesterday).  Unfortunately, I'm still kinda stuck on _which_
kernel tree I'm supposed to be using.  I'm pretty handy with patch, and
I've become aware of the issues with the bmac driver (broken in some
2.2.10 kernels, fixed in vger) and the atyfb, but I've still got
a few things I've got to work out.

I have X working at 1024x768 at 32bpp with the cfb32 (unaccelerated
driver).  It performs decently, but I'd like the accelerated driver.
I'll get that working later.

I have a 3 button USB mouse (Logitech WingMan) I'd like to use with X,
but I can't seem to find a kernel that will (1) not pull a Machine
check error when I build it (raw vger does this) and (2) FIND my
USB mouse.  The lombard.vmlinux that I'm using (from linuxppc.org)
loads the USB code segments, but plugging in a mouse dumps a bunch
of stuff to the console:

get_descriptor failed, waiting
[...]
giving up

Wondered if you'd seen that and know of a fix for it.  I'm building a 
kernel as modules now to see if that makes a difference.

=== on to the real question ===

Feel free to ignore the USB ramblings above, I think I can figure them
out, I just want to know what kernel tree source you're using.  :)

Is it paul's linux-pmac with patches, or is it vger (current CVS 
from, say cvs.on.openprojects.net) with some patches, etc?  Also,
would you be so kind as to send your kernel config my way, so I
can pick out the settings for the USB devices and atyfb?
 
Right now I'm using my own kernels from the linux-pmac 2.2.10
with a patched bmac.  Ethernet works great, atyfb isn't recognizing
my devices, and USB is throwing those errors.  I figure I'd
better figure out which tree is working for people.  :)

-- 
Shaw Terwilliger (sterwill@io.nu)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
