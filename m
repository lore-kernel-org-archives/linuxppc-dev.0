Date: Wed, 12 Jul 2000 16:41:50 +0200
From: Olaf Hering <olh@suse.de>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PMAC SMP on 2.4.0-test1
Message-ID: <20000712164149.B7048@suse.de>
References: <200007112219.PAA29279@soda.csua.Berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200007112219.PAA29279@soda.csua.Berkeley.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 11, Sriranga Veeraraghavan wrote:

> I was able to build a PPC (PMAC) SMP kernel using the 2.4.0-test1
> sources with the PMAC/PPC patches, but I can't seem to get the kernel
> to boot. My machine is a 7600 with a 2 x 200 604e card.
>
> I see the initial boot text from Boot-X, but it never gets to the
> point where it displays the two penguins. Since there is no oops, I'm
> not sure where to start debugging.

A guy with a 9500 machine had success with quik booting, BootX seems
not wo work. Maybe you can try miboot, but I guess the AAPL,ROM leaves
the second processor in a "unknown" state.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
