Message-ID: <3A722CA1.3EAE82AF@mvista.com>
Date: Fri, 26 Jan 2001 21:04:17 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspincom.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint 8240 or 7400
References: <524rylvl3d.fsf@love-boat.topspincom.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Roland Dreier wrote:

> ..... I get
> the same thing on both the 8240 and the 7400.

Got all of those switches set correctly :-)?

> Has anyone gotten Linux to boot on a Sandpoint system?  I'm especially
> interested in the 7400.

Yeah, I'm working on the 7450 as we speak.  Probably won't sleep
this weekend because I need to have the demo done for Linux world.
The Linux part was easy, the demo sucks :-).  I did the original
8240 long ago, which was some "up to date" 2.3.18 kernel or something
at the time.  I'm sure that is still floating around someplace :-).

> Also, if I wanted to build my own kernel for a Sandpoint system, what
> source tree should I use?

Let me clean mine up a little (I'm actually doing 405 at the moment)
and put it on a server someplace.  No promises, but it should be
better than anything else right now.  The Sandpoint seems to always
be one of those "background" projects that can't gain momentum.

> ......  And (forgive the naive question) how do I
> build a kernel image that I can send to the Sandpoint via the serial
> port and start from DINK32?

What version of DINK do you have?  I'll send you my little downloader
as well if you wish.  The easiest way is I just blow the bits over
the JTAG with my Abatron....

> .....  What are the prospects of being able to
> build a PPC kernel from Linus's tree?

It's getting closer, but this Sandpoint stuff still isn't there.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
