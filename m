Date: Thu, 5 Dec 2002 10:35:09 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: Chris Zimman <chris@cryptoapps.com>,
	Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: looking for documentation on porting Linux to PowerPC platforms
Message-ID: <20021205183509.GA10250@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <20021204103839.A28568@crystal.2d3d.co.za> <20021204192129.GA8996@mail.cryptoapps.com> <20021205104856.A3899@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021205104856.A3899@crystal.2d3d.co.za>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 05, 2002 at 10:48:56AM +0200, Abraham vd Merwe wrote:
> I've got a VxWorks boot loader on the thing, so I'm not worrying about a
> boot loader right now. I just need to know what I need to setup before
> branching to the processor. Looking at the source for the 8xx processors, it
> seems I need:

I've never looked at the VxWorks boot loader, so I'm not sure how it
does things.

> ------------< snip <------< snip <------< snip <------------
> r3: ptr to board info data
> r4: initrd_start or if no initrd then 0
> r5: initrd_end - unused if r4 is 0
> r6: start of command line string
> r7: end of command line string
> ------------< snip <------< snip <------< snip <------------
>
> Is that all? Also, what is the "board info data" ?

bd_t contains parameters for the kernel (eg. start of memory, size,
start of flash, etc.).

> I downloaded ppc-patch-2.4.18.bz2 from
> ftp://ftp.kernel.org/pub/linux/kernel/ports/ppc - is that sufficient or is
> there better support in the BK repository?

You'd probably be best getting the code from the BK repository.  Again,
what you most likely want is 2.4.x + platforms.

--Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
