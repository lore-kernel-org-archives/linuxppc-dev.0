Date: Tue, 15 Jul 2003 16:45:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Darin.Johnson@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Message-ID: <20030715164557.A8616@home.com>
References: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>; from Darin.Johnson@nokia.com on Tue, Jul 15, 2003 at 04:04:24PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 15, 2003 at 04:04:24PM -0700, Darin.Johnson@nokia.com wrote:
>
> > IMHO, the easiest solution is
> > alignment of buffers.....plus it's likely to be a performance
> > improvement.
>
> True, it's the easiest solution for the kernel developer, but
> requires more work from driver authors.  Which is ok, *if* it's
> well documented and everyone knows buffers must be aligned,
> and that's the problem.  I think some people implicitly understand
> these issues, and assume that everyone else thinks the same way.

What more do you expect than the "What memory is DMA'able?" section
in Documentation/DMA-mapping.txt?

It's there to refer the developers to. Some maintainers have bugs
in their drivers/subsystems.  They just need a patch from the people
that depend on the bug fix.

I know you are now focusing on some 8xx buffer issue but the original
issue was surrounding generic SCSI subsystem bugs.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
