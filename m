Subject: Re: [PATCH] PPC601 MQ handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef Simoens <stef.simoens@pi.be>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <HZF5JG$8DFE4973242834322717FEB2CD3FE797@scarlet.be>
References: <HZF5JG$8DFE4973242834322717FEB2CD3FE797@scarlet.be>
Content-Type: text/plain
Message-Id: <1087418693.8556.236.camel@gaston>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 15:44:54 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-06-16 at 15:42, Stef Simoens wrote:
> This is a patch to handle the MQ-register found on 601 CPU's. It's a diff against linux-2.6.7. Could this patch be included in further Linux kernels?
>
> The patch can also be downloaded from http://users.tijd.com/~tdn46485/linux-2.6.7-mq.patch
> I also wrote a small testcase (http://users.tijd.com/~tdn46485/mqtest.s)
> The test makes a division, enters a for loop, and prints the contents of the MQ register.
>
> Changes:
> * Add a CONFIG_PPC601_MQ option
> * Set CPU_FTR_MQ for 601 (arch/ppc/cputable.c, include/asm-ppc/cputable.h)
> * Save and restore the MQ register (arch/ppc/entry.S, include/asm-ppc/reg.h)
> * Delete the 'not used' message, mq debug (arch/ppc/kernel/ppc-stub.c, include/asm-ppc/ptrace.h)
>
> Signed-off-by: Stef Simoens <stef.simoens@pi.be>

Did you check it was actually saved/restored by the signal code ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
