Date: Mon, 02 Apr 2001 02:08:19 +0100
Subject: Re: CPU features/ crash at arch:exit
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010402010811.3D356DBA9A@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I just booted with the second CPU wedged (that is to say, bootx from MacOS
>>9) with the same kernel to see what it would do with only 1 cpu, and it
>>still stops at the same place, so I'm guessing the problem should be
>>reproducable on a single-cpu system running an SMP kernel, if that helps
>>any.
>
> Well, I booted succesfully the Pismo (which doesn't use the lost_interrupts
> stuff) with an SMP kernel. So either this is broken, or something else
> related to powersurge is broken.

I'm getting the same problem as Tony (stops dead at arch:exit) on a UP
kernel (g3/beige - BK _2_4 as of 01:00 BST).  [2.4.3]

no xmon interrupt for me either.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
