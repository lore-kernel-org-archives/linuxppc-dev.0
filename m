Date: Mon, 24 Jan 2000 15:05:19 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Ryan Boder <rboder@grn.georet.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rev 14 feedback
In-Reply-To: <388CAB81.E33EC994@grn.georet.net>
Message-ID: <Pine.LNX.3.96L.1000124150354.1087A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Jan 2000, Ryan Boder wrote:
>
> I got the current rsync tree by doing a
> rsync -arvz linuxcare.com.au:: linux-pmac-stable
>
> Then I went to apply the rev 14 patches from Ben's test page, but only a
> few of them worked. Most of them said patch reversed or patch already
> applied. Whatever the case they didn't apply cleanly.
>
> Then when compiling the kernel I got lots of warnings and 2 errors in
> /usr/src/linux/arch/ppc/kernel/prom.c so I removed it and replaced with
> with that file from the last stable tree I had. This let the kernel
> compile and it booted but i still don't have network access.
>
> I know the rsync tree was current because I just got it today (1/24/00).
> I had this problem once before when i was using the wrong source tree
> with the patches. am I screwing up or is there something wrong with the
> patches?

I would imagine Ben's patches are going into Paul's tree. Has Ben said
anything about writing the ethernet driver?

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
