Subject: Re: ibook2 will not wake from sleep on 2.4.20-ben7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030301202916.GA6120@paco.resnet.purdue.edu>
References: <20030301202916.GA6120@paco.resnet.purdue.edu>
Content-Type: text/plain
Message-Id: <1046557102.2030.89.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 01 Mar 2003 23:18:22 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-03-01 at 21:29, Ethan Blanton wrote:
> I have an iBook 2 (PowerBook 4,1) and I rsync'd my kernel to
> 2.4.20-ben7 last night (I had previously been running 2.4.20-pre7-ben0
> with no trouble).  The lid latch does not seem to put the machine to
> sleep any more, and when I put it to sleep with the power button,
> waking the machine up shuts it off rather than waking it.  I then have
> to depress the power button for a few seconds, release it, and press
> it briefly in order to power the machine back up.
>
> The machine is not losing its time/etc, merely shutting down.
>
> I'm running pbbuttonsd-0.5.2 in pmud replacement mode.

Can you try -ben4 or -ben5 ? Patches against official 2.4.20
are on kernel.org/pub/linux/kernel/people/benh.

Let me know if it works

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
