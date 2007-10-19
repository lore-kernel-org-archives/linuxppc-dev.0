Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5BCD@zch01exm26.fsl.freescale.net>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
	<1192195728-24189-7-git-send-email-leoli@freescale.com>
	<1192195728-24189-8-git-send-email-leoli@freescale.com>
	<1192195728-24189-9-git-send-email-leoli@freescale.com>
	<1192195728-24189-10-git-send-email-leoli@freescale.com>
	<20071015003703.GA14108@localhost.localdomain>
	<09B82C85-E2DE-46AD-8ABC-B7A261BAFF6D@kernel.crashing.org>
	<989B956029373F45A0B8AF0297081890019B5BCD@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5DBE800-DA0A-41FF-9F69-6F1BDF3B8841@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 9/9] add MPC837x MDS board default device tree
Date: Fri, 19 Oct 2007 08:04:12 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>
>>>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts
>>>> b/arch/powerpc/boot/dts/mpc8377_mds.dts
>>> [snip]
>>>> +	soc837x@e0000000 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		device_type = "soc";
>>>> +		ranges = <0 e0000000 00100000>;
>>>> +		reg = <e0000000 00000200>;
>>>> +		bus-frequency = <0>;
>>>> +
>>>> +		wdt@200 {
>>>> +			device_type = "watchdog";
>>>
>>> Drop this device_type.
>>>
>>>> +			compatible = "mpc83xx_wdt";
>>>> +			reg = <200 100>;
>>>> +		};
>>>> +
>>>> +		i2c@3000 {
>>>> +			device_type = "i2c";
>>>
>>> And this one.
>>
>> I've asked Leo to leave this one as all other fsl boards do
>> this and the code depends on it.  There was some discussion
>> about this but I wasn't sure if it was closed or not.
>
> I'm afraid not only i2c but also watchdog and spi need device_type  
> now.
> Shall we proceed removing the type check?

We are NOT changing that code until 2.6.25.

- k
