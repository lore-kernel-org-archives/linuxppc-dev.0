Date: Wed, 13 Sep 2000 22:21:21 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Michel Lanners <mlan@cpu.lu>
Cc: paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
Message-ID: <20000913222121.K4546@hq.fsmlabs.com>
References: <200009122018.WAA00786@piglet.grunz.lu> <200009131951.VAA00816@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200009131951.VAA00816@piglet.grunz.lu>; from Michel Lanners on Wed, Sep 13, 2000 at 09:51:25PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I missed a lot of this thread, this is the first message I picked up on.

} To come back to my original question...

It's a dead loss on SMP, but it can be just run on UP machines.  The main
problem was I didn't have enough time to finish it and didn't want to leave
something running in the idle task that I hadn't finished studying the
effect of.

I really wanted to push it up to the freelist since I don't think it's a
PPC-only optimization.  I never bothered trying to push it since at that
point the tree was moving to the stable point and wasn't going to be
changing that radically soon.

} > - is there any problem with using this feature?
}
} I didn't have any, but that's only my box then....

Not without a lot of study and testing.  I haven't touched the code in a
long time...

} What do you think, Paul, Cort?

It's not a matter of turning it on - it's a matter of making it work again
and testing it.

} Maybe enabling it by default would be a good choice? It can always be
} disabled...
}
} I'll post a patch on sourceforge.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
