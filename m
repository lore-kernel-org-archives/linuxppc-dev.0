Return-Path: <segher@kernel.crashing.org>
Received: from localhost.localdomain (adsl-63-203-10-66.dsl.lsan03.pacbell.net
	[63.203.10.66]) by ozlabs.org (Postfix) with SMTP id 490A32BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 15:46:10 +1000 (EST)
Received: from [172.20.101.118] by localhost.localdomain for
	<linuxppc-embedded@ozlabs.org>; Tue, 28 Sep 2004 05:43:40 -7GMT
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <7EA6A11C-1111-11D9-8370-000A95A4DC02@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-embedded@ozlabs.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 28 Sep 2004 00:44:42 -0500
Subject: Fwd: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[Whoops, SMTP problem.  Sorry if it's a duplicate now.]

Begin forwarded message:

> From: Segher Boessenkool <segher@kernel.crashing.org>
> Date: 28 september 2004 0:39:32 GMT-05:00
> To: Matt Porter <mporter@kernel.crashing.org>
> Cc: David Gardiner <daveg@sonartech.com.au>, 
> linuxppc-embedded@ozlabs.org
> Subject: Re: powerpc with gigabit card hanging
>
>>> What kernel are you using?
>
> 2.6.whatever, and I've used 2.4 in the past I believe.
>
>>> it's just that the irq's I'm getting for the
>>> gigabit devices are zero (dual gigabit ethernet card) for the 
>>> 2.6.9-rc2
>>> plus patchs kernel but for the 2.4 series I was getting 12 and 9 as 
>>> can
>>> be seen below and configuring the devices worked fine.
>
> PCI device IRQs are normally retrieved straight from the PCI device
> itself.  Sounds like a firmware problem (or the bootloader, if that
> sets up the PCI devices for you).
>
>> irqs for PCI devices do not come from the driver, they are platform
>> specific.  If you are having problems with the interrupt reported
>> by xyz PCI driver then that is something wrong with your platform.
>> On pmac, interrupt routing is retrieved from OF.
>
> I believe Linux for PowerMac actually gets the IRQ number straight
> from the device.  Some other routing might be gotten out of the OF
> device-tree, yes.
>
>
> Segher
>
