Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3C063DDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 04:15:47 +1100 (EST)
Date: Wed, 17 Dec 2008 20:15:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for
	MPC8360E-MDS boards
Message-ID: <20081217171545.GB10240@oksana.dev.rtsoft.ru>
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192743.GC13035@oksana.dev.rtsoft.ru>
	<8CFD0641-F9CD-4961-A1B3-C702E8E5DFB7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <8CFD0641-F9CD-4961-A1B3-C702E8E5DFB7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17, 2008 at 10:59:09AM -0600, Kumar Gala wrote:
>
> On Dec 3, 2008, at 1:27 PM, Anton Vorontsov wrote:
>
>> - Update the device tree per QE USB bindings;
>> - Add timer (FSL GTM) node;
>> - Add gpio-controller node for BCSR13 bank (GPIOs on that bank
>>  are used to control the USB transceiver);
>> - Set up other BCSR registers;
>> - Configure the QE Par IO.
>
> Of these are they all in the kernel tree already?  What I mean is QE usb 
> bindings in linus's tree?

Yes, they're all in the Linus' tree already (except for simple/bcsr
gpio bindings, which are in this patch series).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
