Message-ID: <3A708795.9D627FE9@mvista.com>
Date: Thu, 25 Jan 2001 15:07:49 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Roman Zippel <zippel@fh-brandenburg.de>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
References: <Pine.HPX.4.10.10101251838570.22074-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> ..... Has anybody
> any docs on how the MMU has been modified to handle the extra bits on the
> 7450.

Yes, I have one and I am working on it.  Although I have been spending
time at the lower end of the processor scale, my changes are directly
applicable to the 7450 enhancements as well.  Of course, we then
have the "common kernel" problem :-).  If I build something to
take advantage of the 7450 enhancements, it may not boot on other
systems.

> The only port which is simple is the 68k

Lots of people complain about it, but I'll agree the 68k MMU
design and supporting instructions is still the best.

> ...... Using such a simple trick for processors which do not allow
> to (easily or not) access alternate address spaces is not an option.

You can easily make the PowerPC have this same alternate address
design.  Either people forget or have never known the value of these
large virtual alternate address space designs, and simply jump to
the common space design we have in Linux.

> ............ Now, assuming that you
> can store one bit in one atom of hydrogen, the weight of 2^128 bytes of
> memory would be in the range of a few 10^9 tons, hardly practical for
> mobile systems ;-)

Of course, you know that 1 bits weight more than 0 bits, right?  I
proved it once.  I wrote a streamer tape with all 0s, weighed it,
then wrote it with all 1s.  It weighed slightly more with all 1s :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
