Date: Fri, 7 Feb 2003 14:01:16 -0700
From: Matt Porter <porter@cox.net>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel build: not recognizing 'tlbre' instruction
Message-ID: <20030207140116.B14341@home.com>
References: <995FF289C9D69747A09E42992644595405B23657@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B23657@penguin.adic.com>; from brian.auld@adic.com on Fri, Feb 07, 2003 at 11:03:09AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 07, 2003 at 11:03:09AM -0800, brian.auld@adic.com wrote:
> (2) Regarding kernel tree without:
>
> 	ifdef CONFIG_4xx
> 	CFLAGS := $(CFLAGS) -Wa,-m405
> 	endif
>
>     in arch/ppc/Makefile.
>
>     The kernel trees that I have all have this set. Is the suggestion
>     to comment this out, or find a kernel without it? If it's the latter,
>     is there a nifty way to do this other than trial and error?

Guess that's not the problem, nm.

--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
