Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 01/13] powerpc/booke: Add Stack Marking support to
	Booke Exception Prolog
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <68EF9A77-EB45-49D5-8496-686918DDC75C@kernel.crashing.org>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191301.20987.70132.sendpatchset@norville.austin.ibm.com>
	<68EF9A77-EB45-49D5-8496-686918DDC75C@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 02 Mar 2010 09:09:06 -0600
Message-Id: <1267542546.32269.20.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-02 at 08:50 -0600, Kumar Gala wrote:
> On Mar 1, 2010, at 1:13 PM, Dave Kleikamp wrote:
> 
> > powerpc/booke: Add Stack Marking support to Booke Exception Prolog
> > 
> > From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
> > 
> > Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
> > Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > ---
> > 
> > arch/powerpc/kernel/head_booke.h |    5 +++++
> > 1 files changed, 5 insertions(+), 0 deletions(-)
> 
> Can this be explained further as to what this gets us or does.

Yeah.  Sorry about that.  This is a debugging aid that identifies an
exception on the stack.  xmon recognizes the marker and identifies the
exception frame in the stack trace.  Other sub-architectures have it,
but bookE is currently missing it.

Ben, Torez,
Is there any reason this patch is re-defining STACK_FRAME_REGS_MARKER
rather than including asm/ptrace.h?

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
