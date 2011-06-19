Return-Path: <paulus@ozlabs.org>
Date: Sun, 19 Jun 2011 11:01:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
Message-ID: <20110619010112.GC7357@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
	<FF184B48-CFBB-42E9-9CAE-897A56172F5E@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FF184B48-CFBB-42E9-9CAE-897A56172F5E@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 18, 2011 at 04:34:14PM +0200, Alexander Graf wrote:

> I just applied them on top of kvm-ppc-next and started compiling for book3s_64_pr=M:
> 
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:314: Error: undefined symbol `PACA_KVM_SVCPU' in operation
> arch/powerpc/kernel/exceptions-64s.S:314: Error: undefined symbol `SVCPU_IN_GUEST' in operation
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2

Ah, good catch, you must be compiling with CONFIG_POWER4_ONLY=n.
I did test compiling for book3s_pr but I had CONFIG_POWER4_ONLY=y.
I'll post revised versions of patches 8/15 and 9/15.

Paul.
