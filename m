Subject: Re: XServe G5 and Linux ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040208180539.GG18479@sunbeam.de.gnumonks.org>
References: <20040208180539.GG18479@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Message-Id: <1076299574.887.118.camel@gaston>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 15:06:14 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-02-09 at 05:05, Harald Welte wrote:
> Hi!
>
> I currently have the requirement for some 1U servers running linux, but
> specifically being not x86.  So apart from the sparc64 systems, there's
> of course the Apple XServe.
>
> I have a couple of questions though:

Well, the machine hasn't yet been released, or if it has, I yet haven't
had any feedback of linux running on it.

> 1) Does anybody have experience running linux on the current G5 Xserve?

I expect the kernel to mostly work, +/- minor adaptations that should be
fairly trivial hopefully, except maybe for the thermal control. But then
it depends what they changed of the chipset. The above is assuming the
chipset is just the new northbridge rev and same IO chip.

> 2) Does the 32bit PPC arch run in SMP on a dual G5 Xserve?

Yes. Though I don't quite support 2.4 on G5s (there _is_ a booting
SMP 2.4 kernel, I'm not sure how stable it is in the long run).

> And a minor curiosity at the end:  Are there any plans to include Apple
> G5 support into the linux ppc64 arch at some point?

It's beeing done, will be upstream soon hopefully.

> Please don't misunderstand me, I'm not 'demanding' anything.  I just
> want to get some information... and information about the linux
> ppc/ppc64 kernel development to be almost non-existent on the net.

You know how to ask :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
