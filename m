Date: Tue, 25 Nov 2003 16:50:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ashwin Bihari <raz0redge@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBug, PrPMC800 and bootargs
Message-ID: <20031125235005.GB2541@stop.crashing.org>
References: <BAY9-F67lXCCzunMkE4000047a9@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY9-F67lXCCzunMkE4000047a9@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 21, 2003 at 04:31:18PM -0500, Ashwin Bihari wrote:
>
> Greetings,
>
> I'm trying to get bootargs working with my Kernel such that I can change the
> root device on the fly from the firmware. I'm using PPC7-Bug and GEVEDIT to
> set the bootargs up.
>
> I can see that bootargs gets set within the firmware, after some digging
> around in the Linux Kenrel I see that it is never being checked/read. I see
> there are some patches for VME, any such thing for the PrPMC800??
>
> I'm using 2.4.23-pre8 off the Linuxppc_2.4_devel branch.

The changes required for this to work are rather trivial, and you should
be able to use the code needed for the Motorola LoPEC as a starting
point of what you need to do (arch/ppc/config.in,
arch/ppc/kernel/Makefile and arch/ppc/platforms/prpmc800_setup.c I
imagine).  Patches would be appreciated.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
