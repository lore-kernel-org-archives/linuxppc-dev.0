Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2880EDDE33
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:04:15 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5BCC@zch01exm26.fsl.freescale.net>
References: <1192702580-6353-1-git-send-email-leoli@freescale.com>
	<9982D235-54B3-4733-8F67-4F75C7D1AFC3@kernel.crashing.org>
	<989B956029373F45A0B8AF0297081890019B5BCC@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2ADE481F-2C20-44A9-BCF3-D1707E97CC94@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 09:04:26 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>, Kim Phillips <kim@kimphillips.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 8:33 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, October 18, 2007 9:17 PM
>> To: Li Yang-r58472
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
>>
>> is it me or are you just posting the patches you're updating?
>>  (this is the only v5 patch I saw in the series)
>
> I'm only posting the patch updated, to prevent spamming the list.  If
> you want, I can send the whole series to you.

I think posting the full patchset for v6 would be good since we've  
gotten that far.

>> On Oct 18, 2007, at 5:16 AM, Li Yang wrote:
>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/
>>> boot/dts/mpc8377_mds.dts new file mode 100644 index 0000000..8530de6
>
>>> +	memory {
>>> +		device_type = "memory";
>>> +		reg = <00000000 20000000>;	// 512MB at 0
>>> +	};
>>> +
>>> +	soc837x@e0000000 {
>>
>> soc@e0000000
>
> I can update this now, but the device tree won't be usable by current
> u-boot.

Its my understanding Kim's going to deal with this in the public u- 
boot tree.

>>> +		spi@7000 {
>>> +			compatible = "mpc83xx_spi";
>>> +			reg = <7000 1000>;
>>> +			interrupts = <10 8>;
>>> +			interrupt-parent = < &ipic >;
>>
>> mode = "cpu";
>
> Oh ya,  the spec has been changed.  I also need to update  
> mpc83xx_spi to
> fsl_spi.
>
> - Leo
