Subject: Re: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031120201249.GB29432@sunbeam.de.gnumonks.org>
References: <20031120201249.GB29432@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Message-Id: <1069386878.876.49.camel@gaston>
Mime-Version: 1.0
Date: Fri, 21 Nov 2003 14:54:38 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-11-21 at 07:12, Harald Welte wrote:
> Hi!
>
> I was trying to get a recent linuxppc-2.5 (or benh) kernel running on my
> G4 Titanium Powerbook IV, and it wouldn't even finish to boot.

Interesting. Same machine here and I use 2.6 everyday :)

> After some debugging, I found it was always crashing when sshd started.
> That in turn was, because the kernel tried to autoload the ipv6.ko
> module for sshd to listen at ::.

Ah...

> booting into single user mode and manually issuing 'insmod ipv6' shows
> exactly the same behaviour:  A full freeze, no more cursor at the
> console, but still responds to pings from the network.

What does your .config looks like ? nothing scary like CONFIG_PREEMPT ?

I'll do some tests here...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
