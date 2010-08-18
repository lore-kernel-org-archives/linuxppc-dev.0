Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] Some 47x patches for the powerpc-4xx tree
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 18 Aug 2010 11:45:59 -0500
Message-ID: <1282149960.3679.0.camel@shaggy-w500.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry!  Forgot to change the subject.

Shaggy

On Wed, 2010-08-18 at 11:44 -0500, Dave Kleikamp wrote:
> Josh,
> Here are some bug fixes for the powerpc-4xx tree.  It'd be nice if they
> could make it into 2.6.46.
> 
> Thanks,
> Shaggy
> 
> Dave Kleikamp (4):
>   powerpc/47x: Make sure mcsr is cleared before enabling machine check
>     interrupts
>   powerpc/47x: Remove redundant line from cputable.c
>   powerpc/4xx: Index interrupt stacks by physical cpu
>   powerpc/47x: Add an isync before the tlbivax instruction
> 
>  arch/powerpc/kernel/cputable.c   |    1 -
>  arch/powerpc/kernel/head_44x.S   |    4 ++++
>  arch/powerpc/kernel/irq.c        |   15 ++++++++-------
>  arch/powerpc/kernel/setup_32.c   |    9 +++++----
>  arch/powerpc/mm/tlb_nohash_low.S |    1 +
>  5 files changed, 18 insertions(+), 12 deletions(-)
> 

-- 
Dave Kleikamp
IBM Linux Technology Center
