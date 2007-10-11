Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD78CDE1B6
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:01:28 +1000 (EST)
In-Reply-To: <18190.39864.4562.852292@cargo.ozlabs.ibm.com>
References: <20071011071558.676463639@au1.ibm.com>
	<20071011072208.075979098@au1.ibm.com>
	<DFC6881D-E917-4EC5-B19C-8CE04E040B06@kernel.crashing.org>
	<18190.39864.4562.852292@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C31F1C3-3337-483B-A463-767459305F1E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/2] Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE #define
Date: Thu, 11 Oct 2007 17:01:43 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 11, 2007, at 4:55 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>>> #define ELF_CORE_XFPREG_TYPE to be NT_PRXFPREG in all current  
>>> users so
>>> there's are no change in behaviour.
>>
>> Can we make this ELF_CORE_VECREG_TYPE or something that is so coupled
>> to the x86 specific name?
>
> How is "extended floating point registers" x86-specific?

we'll I don't consider the altivec register file as 'extended fp'.   
I'm assuming the name XFP came from IA32 land when MMX/SSE came into  
existence.

> ELF_CORE_XFPREG_TYPE is a suitable name for something that's used in
> conjunction with a function called elf_core_copy_task_xfpregs().

agreed, I think the function name should change as well.

- k
