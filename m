Message-ID: <375CD6AC.D259D76E@uab.ericsson.se>
Date: Tue, 08 Jun 1999 10:39:08 +0200
From: Leif Lindholm <Leif.Lindholm@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: udelay not exported to kernel(?) - never mind :)
References: <375C213C.90DBE256@uab.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello again

Hint: don't try to understand the ppc code by looking at how the x86 did
it :)
Especially not if you're tired.

Got a bit confused by the fact that:
a) there are different udelay:s for the loader and for the kernel itself
b) the udelay inside the kernel was an __inline__ and that's why it
didn't show up in System.map :)

apologetically
/
	Leif

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
