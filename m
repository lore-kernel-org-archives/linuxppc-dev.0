Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Santosh Kumar <santoshkumar.a@gmail.com>
Subject: Re: powerpc 476, Little-endian, pte fault
In-reply-to: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
References: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
Date: Mon, 31 Oct 2011 16:51:16 +1100
Message-ID: <12144.1320040276@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding linuxppc-dev list to the CC

> KERNEL: linux 2.6.39.4
> POWERPC: 476, little endian.
> 
> I am trying to get linux 2.6.39.4 up on PPC 476 i have done done
> Big-endian to little endian Changes in:

Can you explain what you are trying to do in more detail?  What does "i
have done Big-endian to little endian Changes" mean?

> 1) bitops header file.
> 2) while reading the device tree.
> 3) the PTE read/computed in head_32.S
> 4) added E bit in the TLB entries.
> 
> with all the above changes the kernel_init is done but and inited is
> mounted.

Can you post your patch?

Are you trying to boot the kernel in little endian or just run userspace
in little endian?  

> But while spawning init process the kernel continuously hits pte
> faults at address 0x100000fc and never comes out. Please let me know
> where i should be looking into.

Is this the very first userspace instruction?

Mikey
