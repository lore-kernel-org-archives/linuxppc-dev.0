Subject: Re: linuxppc-2.5 fixlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
References: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
Content-Type: text/plain
Message-Id: <1061496837.18043.1.camel@gaston>
Mime-Version: 1.0
Date: 21 Aug 2003 22:13:57 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm not sure how to fix the same warning in drivers/ide/ppc/pmac.c
> though:
>
> if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
>
> DMA_WAIT_TIMEOUT is 500, but drive->waiting_for_dma is a u8.

Fixed in my tree and in the version pending for Linus

> PS: I guess Ben's PM fixes haven't made it into linuxppc-2.5 yet? The
> display is garbled after sleep.

Not yet.

I'm preparing a new set of patches that include all my driver
changes except the video ones. I'll send those ones separately to
James first as they rely on some fbdev infrastructure changes.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
