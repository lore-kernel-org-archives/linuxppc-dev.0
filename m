Return-Path: <gerlach@kip.uni-heidelberg.de>
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de
	[129.206.210.211])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28B46DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 19:20:04 +1000 (EST)
Message-ID: <46DE664E.9040805@kip.uni-heidelberg.de>
Date: Wed, 05 Sep 2007 10:18:22 +0200
From: Thomas Gerlach <gerlach@kip.uni-heidelberg.de>
MIME-Version: 1.0
To: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
Subject: Re: Newbie on embedded linux on PPC: error: cannot find boot.o
References: <46DD65BF.5090304@kip.uni-heidelberg.de>
	<20070904213339.D3DB7788046@mail56-fra.bigfish.com>
In-Reply-To: <20070904213339.D3DB7788046@mail56-fra.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Reissnegger wrote:
> Hi Thomas,
>
> Xilinx is building the tools in the EDK to work with VxWorks and for Standalone systems. In order to compile a Linux kernel you need to get a toolchain from one of the Third Party vendors, such as MontaVista. They have the correct linker scripts for building a kernel.
>
> Cheers,
>    Wolfgang
>
> Thomas Gerlach wrote:
>   
>> hi folks,
>>
>>
>> my name is thomas trying to make embedded linux run on a powerpc, but
>> we've got special boards here, although we use a xilinx virtex4
>> fpga...
>>
>> as you said in the nabble-thread (see subject), i set up edk9.1
>> software platform settings und ran libgen to get the xparameters*
>> files. i copied those bsp files into the kernel tree (i use your
>> kernel linux-2.6-virtex from git.secretlabs.ca/git). after
>> configuring the kernel settigs, i try
>>
>> $ make ARCH=ppc CROSS_COMPILE=powerpc-eabi-
>>
>> what i get is the following output:
>>
>>     
>>>   CHK     include/linux/version.h
>>>   CHK     include/linux/utsrelease.h
>>>   CALL    scripts/checksyscalls.sh
>>>   CHK     include/linux/compile.h
>>>   LD      init/mounts.o
>>> powerpc-eabi-ld: cannot find boot.o
>>> make[1]: *** [init/mounts.o] Error 1
>>> make: *** [init] Error 2
>>>       
>> so, i searched for boot.o (it exists) and even copied it into several
>> dirs of the linux kernel tree (where i thought i would make sense),
>> but the problem still remains.
>>
>> googling results in
>>
>> http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&getPagePath=17462&BV_SessionID=@@@@1197140711.1188909240@@@@&BV_EngineID=cccgaddllgmfkflcefeceihdffhdfkf.0
>>
>>
>> and this, too, doesn't take me further in solving the problem.
>>
>> i hope you can help me.
>>
>> many thanks in advance,
>>
>> kind regards
>> thomas gerlach
>>     

hi,
thank you much for this hint, i'll try it. this was the last thing i 
thought of... ;)

kepp on cross-compiling, :)

regards
thomas
