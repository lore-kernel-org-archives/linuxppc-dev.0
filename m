Message-ID: <3E8DA82A.9070809@embeddededge.com>
Date: Fri, 04 Apr 2003 10:43:38 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Till Straumann <strauman@slac.stanford.edu>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLIEMCFLAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> hmm, no response from the maintainer(s). You don't agree?

It's interesting to watch these hacks, but I can't justify
complicating a general purpose function with more bus cycles by
emulating a functional problem.  By not using these instructions
we have a working system that costs just a few more cycles during
the memory copy/zero operations.  If we had _working_ dcbz
instructions, it would be a gain to use them, but from a system
perspective it is going to cost more to "fix up" these than
the code that already exists.

As I said in the past, I'm sensitive to the code in the TLB exception
processing.  So do something to remove code and streamline the process
and I'm really interested.  Do something to add more code and it's
going to get placed pretty low in my pile of things to do.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
