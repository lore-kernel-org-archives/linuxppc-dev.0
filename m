In-Reply-To: <388CAB81.E33EC994@grn.georet.net>
Date: Mon, 24 Jan 2000 21:09:17 +0100
To: rboder@grn.georet.net, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Rev 14 feedback
Message-Id: <20000124210917.032461@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 24, 2000, Ryan Boder <rboder@grn.georet.net> wrote:

>Then I went to apply the rev 14 patches from Ben's test page, but only a
>few of them worked. Most of them said patch reversed or patch already
>applied. Whatever the case they didn't apply cleanly.
>
>Then when compiling the kernel I got lots of warnings and 2 errors in
>/usr/src/linux/arch/ppc/kernel/prom.c so I removed it and replaced with
>with that file from the last stable tree I had. This let the kernel
>compile and it booted but i still don't have network access.
>
>I know the rsync tree was current because I just got it today (1/24/00).
>I had this problem once before when i was using the wrong source tree
>with the patches. am I screwing up or is there something wrong with the
>patches?

I think Paul begun merging my patches in. You should wait a few days for
things to settle down.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
