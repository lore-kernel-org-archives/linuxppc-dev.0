Date: Tue, 25 Feb 2003 06:24:22 -0700
From: Matt Porter <porter@cox.net>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch
Message-ID: <20030225062422.A9657@home.com>
References: <995FF289C9D69747A09E42992644595405B23686@penguin.adic.com> <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net>; from ebs@ebshome.net on Mon, Feb 24, 2003 at 02:29:18PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 24, 2003 at 02:29:18PM -0800, Eugene Surovegin wrote:
> I used George Anzinger patch (it looked less intrusive than 0(1) to me)
> with small fixes.
>
> Actually I applied 3 different patches to achieve reasonable user-mode soft
> real-time for 440GP kernel:
>
> 1) preempt patch (from MVL)
> 2) rtsched by George Anzinger
> 3) lock-break by RML
>
> I can make a patch for 2.4.19 PPC devel tree snapshot with all those
> patches and my fixes if you want.
>
> I'm not sure whether I should post it to the list or not.

I think these things have generally wide interest.  I'm more than
willing to host them at source.mvista.com with the 440gp mmap patches
that are already there.

I suppose we should get a pointer from penguinppc.org's patch page
to this site.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
