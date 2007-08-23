Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C757DDF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 12:34:38 +1000 (EST)
In-Reply-To: <12286518.post@talk.nabble.com>
References: <12286518.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C5046FD2-6781-4E6E-847B-1BDB24E5D81F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Section mismatch warning
Date: Wed, 22 Aug 2007 21:36:36 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 9:30 PM, sivaji wrote:

>
> Hi,
>         When compiling the 2.6.23-rc3 kernel,  i got following warning
> messages.
>
> WARNING: vmlinux.o(.text+0x18): Section mismatch: reference to
> .init.text:early_init (between '__start' and '__after_mmu_off')
> WARNING: vmlinux.o(.text+0x3834): Section mismatch: reference to
> .init.text:machine_init (between 'start_here' and 'set_context')
> WARNING: vmlinux.o(.text+0x383c): Section mismatch: reference to
> .init.text:MMU_init (between 'start_here' and 'set_context')
> WARNING: vmlinux.o(.text+0x3866): Section mismatch: reference to
> .init.text:start_kernel (between 'start_here' and 'set_context')
> WARNING: vmlinux.o(.text+0x386a): Section mismatch: reference to
> .init.text:start_kernel (between 'start_here' and 'set_context')
>
> Processor            : 8641D
> Give some idea how to overcome this warning.

There is a patch posted on the list for this.  I doubt will fix these  
for 2.6.23 as they are just warnings.

http://patchwork.ozlabs.org/linuxppc/patch?id=13066

- k
