Message-ID: <3EC92C16.2080105@mvista.com>
Date: Mon, 19 May 2003 14:10:14 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Dave Strout <dstrout@linuxfoundary.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ssh on ppc 405gp?
References: <1053370861.9594.61.camel@dstrout.nsw.enterasys.com>
In-Reply-To: <1053370861.9594.61.camel@dstrout.nsw.enterasys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes we ship ssh on all of our targets.  And it works correctly.  I have not seen
that message before, so I don't have any suggestions for you.. Sorry.

--Mark

Dave Strout wrote:
> Has anybody succeeded in getting ssh to work on a 405GP machine?  I've
> checked the archives, and seen a couple of reports of problems, but no
> solutions.
>
> I get the following error when trying to connect between a ppc machine
> and an intel machine in either direction:
>
> Received disconnect from 192.168.1.2: 2: Corrupted MAC on input.
>
> If I ssh from the ppc to the ppc via 'localhost', it works.  That makes
> me think that it's something to do with either byte ordering of
> structure alignment, but I don't have any thoughts beyond that...  Any
> suggestions on how to tackle this are welcome.
>
> thanks,
> dave.
>
> --
> Dave Strout
>
> dstrout@linuxfoundary.com    301/869-0818(h)  240/731-2727(c)
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
