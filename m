In-Reply-To: <v04210101b4d0e527f293@[192.168.3.42]>
Date: Thu, 17 Feb 2000 11:18:08 +0100
To: GIANT Network Productions <gnp@jollygreen.com>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: GMAC ethernet
Message-Id: <20000217111808.000326@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 16, 2000, GIANT Network Productions <gnp@jollygreen.com> wrote:

>What's the current status of the GMAC ethernet driver? I've been
>looking to do several things with an iBook that require interface
>aliases and multicast, but those features aren't currently supported.
>I've been pulling linux-pmac-benh from linuxcare.com.au, but Paul
>mentions that Ben's changes have been merged into linux-pmac-stable
>on his new status page and Ben states that he's working on
>'experimental' stuff only...

We could probably allow multicast by enabling the controller's promisc.
mode and let the kernel filter out packets. Not the most efficient thing
but at least it would work until we have some details about the chip's
hash table layout. I'll look into this, but my iBook's hard disk is dead,
I'm still waiting for a replacement.

>I'm less concerned with video performance (which seems to be where
>Paul is focusing at the moment) than with networking features - Which
>tree should I be pulling to keep better tabs on this issue?

Stick to Paul's tree. atyfb doesn't work on the iBook rage mobility yet,
but offb along with accelerated X server works for now. I'll do some work
on atyfb real soon (probably this week-end) to fix other problems, I'll
also try to fix it on the iBook. XServer acceleration already works (at
least with Xpmac).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
