Date: Sat, 13 Oct 2001 13:14:02 -0400
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: interesting line in process.c
Message-ID: <20011013131402.A26264@nevyn.them.org>
References: <15304.11248.720092.645241@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15304.11248.720092.645241@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 13, 2001 at 09:56:32PM +1000, Paul Mackerras wrote:
>
> I'm intrigued by this line, line 276 in arch/ppc/kernel/process.c in
> linuxppc_2_4_devel:
>
> #if defined(CONFIG_4xx) && defined(DCRN_PLB0_BEAR) && defined(DCRN_PLB0_BEAR)
>
> When could we have DCRN_PLB0_BEAR defined but DCRN_PLB0_BEAR not? :)
> Could it ever be defined if CONFIG_4xx was not defined?
>
> Which brings up another question that I have been meaning to ask: what
> is the rationale for adding the dbcr0/1 fields to the ptrace struct
> for 4xx?
>
> Since struct ptrace is part of the kernel/user ABI, I prefer not to
> change it unless it is absolutely necessary.  Could the dbcr0/1 fields
> go in the thread_struct instead?  Where and how are they used?

Well, I don't know anything about the 4xx, so this might not be
reasonable - but could they be used in setting hardware breakpoints?

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
