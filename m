Date: Mon, 17 Nov 2003 19:36:31 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Juergen Kienhoefer <juergen@kienhoefer.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: cache coherence problem
Message-ID: <20031117193631.A16808@home.com>
References: <3FB972E8.5090701@kienhoefer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB972E8.5090701@kienhoefer.com>; from juergen@kienhoefer.com on Mon, Nov 17, 2003 at 05:16:24PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 05:16:24PM -0800, Juergen Kienhoefer wrote:
> Guys,
> Look at the folloging test program. It mmaps memory, puts some
> instructions in it and executes it.
> Sometimes it works, sometimes it crashes with illegal instruction.
> This smells like cache problems.
> Should the kernel clean the instruction cache for these addresses
> in mmap system call?

What processor is this on?

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
