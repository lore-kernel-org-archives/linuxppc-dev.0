Message-ID: <393D3D63.E3504DE9@embeddededge.com>
Date: Tue, 06 Jun 2000 14:05:23 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Montgomery <tmontgom@miranda.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Running from ROM
References: <200006052137.RAA29282@rome.wavemark.com> <393C23CC.3289DD1F@mvista.com> <00060516034300.24189@minotaur.mvista.com> <200006061339.JAA30741@rome.wavemark.com> <393D06BD.ADEDF247@miranda.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Montgomery wrote:


> .... What I have gathered from
> lurking here is that embedded linux operates like PC linux, and that is
> not the model we are looking for.

Hmmm.  It is quite different from a workstation version from my
perspective.  On the other hand, the workstation version of Linux
contains many features we can (and want to) utilize.

If you want to make Linux look like a primitive RTOS, you can hard
code a bunch of variables and write some simple kernel threads and
be done.  Most people are tired of primitive RTOS environments and
want something with the features and configurability of a workstation
in a smaller package.  That's probably why embedded Linux appears to
look like a workstation to you.  Why not utilize those features when
it is beneficial?

> .... Running from ROM makes sense to us,
> too.

OK, explain this to me.  It doesn't make any sense to me for the
following reasons:

	Flash ROM is more expensive than equivalent sized DRAM
	Flash ROM is more difficult to acquire
	I can compress the kernel and file system into a single
		8-bit device, saving substantial board space.
	Flash ROM is typically slower access than DRAM
	Small DRAM parts are getting harder to find and more
		expensive, so you may as well use more DRAM
	Running the kernel from flash may save 600K or so of RAM
		and require an additional 500K of Flash ROM (because it
		isn't compressed any more)

I have seen some very versatile and cost effective systems that use
a tiny Flash rom and Compact Flash for storage.  Above some size (like
16 Mbytes or so), Compact Flash is more economical than soldered on
board flash.  It is also much easier to manage and adds product
flexibility.

Execution from Flash ROM is harder to debug and configure, increasing
development time.

I like learning new things.....explain why running from Flash is better
for your system.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
