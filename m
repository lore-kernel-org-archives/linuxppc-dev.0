To: David Edelsohn <dje@watson.ibm.com>
Cc: Richard Henderson <rth@cygnus.com>, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
References: <9908120516.AA43198@marc.watson.ibm.com>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 12 Aug 1999 09:32:33 +0200
In-Reply-To: David Edelsohn's message of "Thu, 12 Aug 1999 01:16:14 -0400"
Message-ID: <d3k8r178tq.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:

>>>>> Richard Henderson writes:
Richard> But it isn't zero cost.  It's not high cost, but that's not
Richard> the same thing.

David> 	Is your assumption that you want to provide the infrastructure
David> to write high-performance device drivers or to write device
David> drivers that don't require as much expertise and knowledge to
David> produce correct results?  There are conflicting goals in this
David> design providing different benefits to Linux.

I am certainly up for high performance device drivers. Even having
writel do the syncing there are enough other pitfalls for people to
take into account. Some of these are much harder to understand than
dealing with write ordering and as such, trying to make things
invisible are only giving us a false guarantee. Ie. if we want to use
spin locks in the kernel we need to teach people how to use them
correctly.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
