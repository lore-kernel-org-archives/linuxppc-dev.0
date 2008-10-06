Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66D2DDDDE0
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Oct 2008 11:05:47 +1100 (EST)
Subject: Re: 2.6.27-rc8 boot failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <1223055651.3419.47.camel@badari-desktop>
References: <1223055651.3419.47.camel@badari-desktop>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 11:05:40 +1100
Message-Id: <1223251540.8157.0.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-03 at 10:40 -0700, Badari Pulavarty wrote:
> Hi,
> 
> I am not able to boot my Power5 box with 2.6.27-rc8 (defconfig).
> However, I am able to boot with my own custom config.
> 
> Known issue ?

Nope. It would be useful to know the difference between the 2 configs
tho :-)

It -could- have something to do with the kernel size too.

Cheers,
Ben.

> Thanks,
> Badari
> 
> 
> boot: 2627rc8 
> Please wait, loading kernel...
>    Elf32 kernel loaded...
> 
> zImage starting: loaded at 0x040001fc (sp: 0x019ffa80)
> Allocating 0xac3450 bytes for kernel ...
> OF version = 'IBM,SF225_096'
> Trying to claim from 0x40001fc to 0x43d31fc (0x3d3000) got ffffffff
> gunzipping (0x01c00000 <- 0x040071fc:0x043c6dac)...done 0xa1d130 bytes
> 
> Linux/PowerPC load: root=/dev/sdb3 selinux=0 elevator=cfq 
> Finalizing device tree... using OF tree (promptr=00c39a50)
> DEFAULT CATCH!, exception-handler=fff00700 
> at   %SRR0: 000000000257a02c   %SRR1: 0000000000083002 
> Open Firmware exception handler entered from non-OF code
> 
> Client's Fix Pt Regs:
>  00 0000000000000000 00000000019ffa80 0000000000000000 0000000000000000
>  04 0000000000000000 0000000000c39a50 0000000000003002 00000000043d2a00
>  08 0000000000000023 00000000043d2e00 0000000000000014 0000000000000010
>  0c 0000000024004024 0000000000000000 0000000000000000 0000000000000000
>  10 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  14 0000000000230000 0000000000000000 0000000000c84100 0000000000000000
>  18 0000000000000000 0000000001c00000 0000000000ac3450 0000000001c00000
>  1c 0000000000000000 00000000040066c4 000000000400e500 00000000043d2e44
> Special Regs:
>     %IV: 00000700     %CR: 24002022    %XER: 20000000  %DSISR: 00000000 
>   %SRR0: 000000000257a02c   %SRR1: 0000000000083002 
>     %LR: 00000000040009ec    %CTR: 0000000001c00000 
>    %DAR: 0000000000000000 
> Virtual PID = 0 
> PFW: Unable to send error log!
>  ok
> 0 > 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
