Message-Id: <200004260908.LAA14516@denx.local.net>
To: duncanp@research.canon.com.au
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: flash drivers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Apr 2000 19:29:52 +1000."
             <20000426082939.EC8373C960@elph.research.canon.com.au>
Date: Wed, 26 Apr 2000 11:08:20 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20000426082939.EC8373C960@elph.research.canon.com.au> you wrote:
>
> I'm about to go and write some software to allow us to program on-board
> flash devices. I'm planing on putting all of the code in a kernel
> driver - i've seen some flash drivers which put some code in the
> kernel, and other code (to write the flash - I gather the algorithms
> vary a fair bit between deivices) in user space.

For CFI conformant FLASH devices you can use (or  easily  adapt)  the
FLASH  driver  that is included with my port of Linux for the TQM8xxL
board; get ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz and have
a look at the files  CDK/patches/linux-2.2.13/FLASH.patch  and  maybe
CDK/patches/linux-2.2.13/FTL.patch

> So, before I go and do this, has anyone already done something similar
> they would be happy to share with me?

While I was trying to make this as portable as possible, I only could
test it in a configuration with two banks of 16 bit FLASH memory. You
may have to make minor adjustemnts for other configurations.

Feedback appreciated.

> I'd like to write this so it can be dropped into the standard kernels
> and adapted to new 8xx based boards without much effort, so if anybody
> has any comments they'd like to make, please lemme know.

If my version of the drivers proves helpful, I'd  like  to  integrate
whatever changes needed to make it work on other hardware as well.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Roses are red
Violets are blue
Some poems rhyme

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
