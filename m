Date: Fri, 26 Feb 1999 11:35:58 +1100 (EST)
From: Nathan Hurst <njh@drongo.anu.edu.au>
To: "sean o'malley" <somalley@ed.mde.state.mi.us>
cc: "Robert G. Werner" <rwerner@lx1.microbsys.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Beowulf Who?
In-Reply-To: <v04003a05b2fb2d91923b@[204.22.210.180]>
Message-ID: <Pine.LNX.3.95.990226113128.9945G-100000@drongo.anu.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Feb 1999, sean o'malley wrote:

> In this model with a firewire backbone, you basically use the network as
> the machines bus you can drop harddrives on the network as well as stack of
> ram (of which you dont need tcp/ip to utilize ie you give your harddrive an
> ip number? *ponders*)  The virtual machine will basically steal individual
> cycles from machines to process its information.  Not in big chunks but in
> rather tiny chunks thus the worry about network overhead.

For this I think firewire is too slow also.  It is only 400Mbps = 50MBps,
which is going to make an external memory access take 20ns per byte, with
an overhead of about 1us.  I agree that firewire is better than 100Mb
ethernet, but only because firewire doesn't have the slow packet structure
of ethernet/IP.

> No, it wont be as efficient as an SMP machine, nor as fast.  But lets say
> you work in an office building with 400 people and they each have their own
> computer.  You could get a lot of extra juice out of say your secretary's
> machine while she is off on lunch or taking a phone call or while your
> talking to her.

Does firewire handle this many nodes?  Corba already does this, btw.

> You also couldnt use TCP/IP for this model either because there is no
> "real" machine its existence is all the parts of the network, not one
> aspect of it.  You dont really want to assign harddrives IP numbers nor
> would you want to assign it to blocks of ram or scanners on the network
> when in fact you dont need them..

How would you reference them if they don't have some form of reference
number?

njh


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
