Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89A28DFDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:41:56 +1000 (EST)
Message-Id: <CD8F8552-EF7C-4A01-886B-D320A5C432FD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080625173031.ebe238eb.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 3/3] mpc8313erdb: Add power management to the device tree.
Date: Thu, 26 Jun 2008 08:41:46 -0500
References: <20080625215139.GC11784@loki.buserror.net>
	<20080625173031.ebe238eb.kim.phillips@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 25, 2008, at 5:30 PM, Kim Phillips wrote:

> On Wed, 25 Jun 2008 16:51:39 -0500
> Scott Wood <scottwood@freescale.com> wrote:
>
>> +			crypto@30000 {
>> +				device_type = "crypto";
>> +				model = "SEC2";
>
> I thought we were done with the two above properties..
>
>> +				compatible = "fsl,sec2.2", "fsl,sec2.1",
>> +				             "fsl,sec2.0";
>> +				reg = <0x30000 0x7000>;
>> +				interrupts = <11 0x8>;
>> +				interrupt-parent = <&ipic>;
>> +				/* Rev. 2.2 */
>> +				num-channels = <1>;
>> +				channel-fifo-len = <24>;
>> +				exec-units-mask = <0x0000004c>;
>> +				descriptor-types-mask = <0x0122003f>;
>
> ..and prefixed the above four with "fsl,", as in:
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=18726
>
> what's the status of that patch, btw?

There were some comments from Segher that never seemed resolved.

- k
