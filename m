Message-ID: <384FF0B4.E59398ED@netx4.com>
Date: Thu, 09 Dec 1999 13:11:00 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC ERROR 41200000 on CLLF-860T
References: <19991209002442.41D86118CD@elph.research.canon.com.au> <kfyr9gwz7j7.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:


> On vxworks the same program gives about 27 Mbit throughput, and
> Windriver claims this is a limitation in the hardware...

Of course they would.  There are lots of stories floating
around about the 8xx hardware limitations.  There are manual
pages and application notes that describe how the 8xx hardware
works (in particular the CPM), and how you compute the capabilities.
In my experience, it has lived up to the publications.  You can
do things that are simply inefficient, or think about the
system architecture or application and program it to do the
things it can perform.

Even if it is "only" 20 something Mbits, how does that affect
your application?  That is more than double what Graham was
expecting for his.

Remember Ethernet is a shared resource without any
deterministic or bandwidth guarantees.  If it doesn't meet
your requirements, perhaps you should choose from the
variety of other interfaces the 8xx provides.

It can run an infinite loop as fast as anything else........



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
