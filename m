Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id EE171DDE07
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 18:30:03 +1000 (EST)
Message-ID: <48732588.8020907@matrix-vision.de>
Date: Tue, 08 Jul 2008 10:30:00 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] Add MPC5200B base board mvBC-P
References: <4871D065.8080709@matrix-vision.de>
	<20080708034427.GD1549@yookeroo.seuss>
In-Reply-To: <20080708034427.GD1549@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson schrieb:
> On Mon, Jul 07, 2008 at 10:14:29AM +0200, Andre Schwarz wrote:
>   
>> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
>> controller (using e1000). It's just another MPC5200_simple board.
>>     
>
> [snip]
>   
>> +		timer@600 {	// General Purpose Timer
>> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>> +			reg = <0x600 0x10>;
>> +			interrupts = <1 9 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +			fsl,has-wdt;
>> +		};
>> +
>> +		timer@610 {	// General Purpose Timer
>> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>> +			cell-index = <1>;
>>     
>
> What shared resource is this cell-index value used to index?
>
> Also why does it not appear on the timer@600 but does on all the
> others.
>
>   
Sorry - it's a copy paste problem. At first I only used timer0, i.e.
this is the original entry.
After Grant wanting me to have a look at the lite5200b.dts I copied over
the rest of the dts nodes I also have on my board. On lite5200b.dts the
cell-index is defined.

If this is incorrect I'll remove it.
Is cell-index inappropriate for the timer node ?


regards,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
