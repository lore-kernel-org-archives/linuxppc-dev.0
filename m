Message-ID: <37DD34C2.55571353@jlc.net>
Date: Mon, 13 Sep 1999 13:30:42 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC: porting to new platforms
References: <37DC6656.2A40D04D@ctam.com.au> <37DC7E94.946FBA49@jlc.net> <37DC8FE8.E1ED6636@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> ..... I do not want to
> waste any more time getting things working on other boards.

Well, that was kind of my point.  Get a board that already runs
Linux/PPC and you are done.  At least you get to see how it looks.


> 2) The ADS board that I have access to is a loan to us (at no cost).


They will cost you.....lots.  I couldn't believe how much time I
invested just so I could develop the FEC driver.....


> I can imagine.  There seems to be a LOT happening in the LinuxPPC world.

Although now is a good time for updates....I could break it
quite badly and no one would notice :-).

The other reason I post the tar images is most of the requests
for Linux on these processors comes from companies behind firewalls
that can't access CVS.


> ....  What is the
> latest with regards to silicon bugs in the 82XX series ?  What revision have
> you been working with ?

I am running with some pretty early versions.  I am also hearing
the stories but haven't found anything on my side....and can't find
anyone using the processor to admit to bugs either.  The 82xx
processors are a big complexity step for embedded processors, much
more than the 8xx.  Things that have looked like bugs to me turn
up to be configuration errors.....lots of registers to get set
correctly.

Right now I am working on the Sandpoint board.  I have the kernel
basically booting, and I am sorting out the PCI and interrupt
controller stuff.  It's one of those kind-of-CHRP, but not really
configurations.  The 8260 is a completely different beast from
the 8240.  More like a souped up 8xx.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
