Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8387ADDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 05:58:20 +1100 (EST)
In-Reply-To: <20070112095213.GA24536@lst.de>
References: <ZCH01EXM20D0kWSxlXp000006f8@zch01exm20.fsl.freescale.net>
	<20070112095213.GA24536@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <048A2BB9-66FF-494F-8A6B-2649D8B96DBD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 12 Jan 2007 12:57:36 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2007, at 3:52 AM, Christoph Hellwig wrote:

> On Fri, Jan 12, 2007 at 01:31:02PM +0800, ebony.zhu@freescale.com  
> wrote:
>> +ifeq ($(CONFIG_SPE),y)
>> +ifneq ($(CONFIG_MATH_EMULATION),y)
>> +core-y				+= arch/powerpc/math-emu/
>> +endif
>> +endif
>>  core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
>
> This statement doesn't make any sense.  I guess you always want to
> build arch/powerpc/math-emu if CONFIG_SPE is set, right?  The proper
> way to do that is to force CONFIG_MATH_EMULATION in the Kconfig.
>
> Then again we need a really good explanation why CONFIG_SPE should
> force the math emulation to be built.

I'm a little confused if there is a question about the approach  
taken?  Are you asking is there some way of doing the exception  
handling w/o fully emulating the instruction?

Agree that the build system modifications in this patch set need some  
fixing, just trying to understand if there is a larger design query  
here or not?

- k
