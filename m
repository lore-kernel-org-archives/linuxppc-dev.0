Return-Path: <gerlach@kip.uni-heidelberg.de>
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de
	[129.206.210.211])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51650DDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 19:18:08 +1000 (EST)
Message-ID: <46DE65FF.3040202@kip.uni-heidelberg.de>
Date: Wed, 05 Sep 2007 10:17:03 +0200
From: Thomas Gerlach <gerlach@kip.uni-heidelberg.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Newbie on embedded linux on PPC: error: cannot find boot.o
References: <46DD6238.6030204@kip.uni-heidelberg.de>
	<fa686aa40709040747j503a2054x27ba2b8146a93ff8@mail.gmail.com>
In-Reply-To: <fa686aa40709040747j503a2054x27ba2b8146a93ff8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 9/4/07, Thomas Gerlach <gerlach@kip.uni-heidelberg.de> wrote:
>   
>> hi folks,
>>
>>
>> my name is thomas trying to make embedded linux run on a powerpc, but we've got special boards here, although we use a xilinx virtex4 fpga...
>>
>> as you said in the nabble-thread (see subject), i set up edk9.1 software platform settings und ran libgen to get the xparameters* files. i copied those bsp files into the kernel tree (i use your kernel linux-2.6-virtex from git.secretlabs.ca/git). after configuring the kernel settigs, i try
>>
>> $ make ARCH=ppc CROSS_COMPILE=powerpc-eabi-
>>     
>
> You should be using a Linux cross compiler, not powerpc-eabi-.  The
> Xilinx cross compiler will not work to compile Linux kernels.
>
> You can build yourself a cross compiler using 'crosstool':
> http://www.kegel.org/crosstool.
>
> Alternately, you can download ELDK:
> http://www.denx.de/wiki/view/DULG/ELDKAvailability
>
> Cheers,
> g.
>
>   

hi,
thank you much for this hint. this was the last thing i thought of... ;)

so long, keep on cross-compiling! :)

regards,
thomas
