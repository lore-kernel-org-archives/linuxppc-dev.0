Date: Thu, 18 Mar 1999 17:25:24 +1100 (EST)
From: Nathan Hurst <njh@drongo.anu.edu.au>
To: Paul.Mackerras@cs.anu.edu.au
cc: dmalek@jlc.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac Audio
In-Reply-To: <199903172328.KAA18385@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.95.990318172410.19070F-100000@drongo.anu.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Mar 1999, Paul Mackerras wrote:

> Peter Barker and Nathan Hurst here spent some time working on sound
> input.  I'll try to dig up the patch and post it here.

Yes, but the input code never did quite work - I suggest you have a play
with it first (and unscramble our mess).  The mixer code works well, it
might be prudent to lobotomize the driver to just do mixer for now?

njh

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
