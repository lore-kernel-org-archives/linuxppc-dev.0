Date: Thu, 12 Aug 1999 19:58:05 +1000
Message-Id: <199908120958.TAA30553@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: rth@cygnus.com
CC: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
In-reply-to: <19990812003318.A14941@cygnus.com> (message from Richard
	Henderson on Thu, 12 Aug 1999 00:33:18 -0700)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au> <19990811214049.A14692@cygnus.com> <199908120500.PAA30022@tango.anu.edu.au> <19990811224344.A14713@cygnus.com> <199908120707.RAA30438@tango.anu.edu.au> <19990812003318.A14941@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Henderson <rth@cygnus.com> wrote:

> No, 2 Cycles to L1 cache.  One cycle to execute the store,
> which merely adds an entry to the store buffer.

Yes, of course, silly me.  Same on PPC.

> > (Ob. nitpicking: if a wmb takes 12 cycles, how come we can do a wmb
> > and 8 stores in 10 cycles? :-)
> 
> Because it doesn't work like that.  wmb adds a magic token to the
> store buffer that prevents write combining and other such hw
> optimizations.  Timing

Then why is there such a big performance impact from the wmb's?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
