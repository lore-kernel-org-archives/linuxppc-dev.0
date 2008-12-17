Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55459DDF03
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:24:07 +1100 (EST)
Message-Id: <08DF1088-4A51-40DD-9856-9450F4712733@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081217171545.GB10240@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for
	MPC8360E-MDS boards
Date: Wed, 17 Dec 2008 14:21:53 -0600
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192743.GC13035@oksana.dev.rtsoft.ru>
	<8CFD0641-F9CD-4961-A1B3-C702E8E5DFB7@kernel.crashing.org>
	<20081217171545.GB10240@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 17, 2008, at 11:15 AM, Anton Vorontsov wrote:

> On Wed, Dec 17, 2008 at 10:59:09AM -0600, Kumar Gala wrote:
>>
>> On Dec 3, 2008, at 1:27 PM, Anton Vorontsov wrote:
>>
>>> - Update the device tree per QE USB bindings;
>>> - Add timer (FSL GTM) node;
>>> - Add gpio-controller node for BCSR13 bank (GPIOs on that bank
>>> are used to control the USB transceiver);
>>> - Set up other BCSR registers;
>>> - Configure the QE Par IO.
>>
>> Of these are they all in the kernel tree already?  What I mean is  
>> QE usb
>> bindings in linus's tree?
>
> Yes, they're all in the Linus' tree already (except for simple/bcsr
> gpio bindings, which are in this patch series).

Ok.  If you fixup my comment about splitting up patch 2/5 & 3/5 w/ 
regards to BCSR GPIO and repost the patch series (excluding 1/5 since  
that is in my tree) I'll apply all these since they look good.

- k
