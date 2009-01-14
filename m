Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BD80DE10B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 01:35:33 +1100 (EST)
Message-Id: <A658F527-6373-47A5-BD28-66C657662B72@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090114142135.GA22862@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] dts-bindings/fsl/dma.txt: fix IRQ number in mpc83xx dma
	example
Date: Wed, 14 Jan 2009 08:35:27 -0600
References: <1231942453-17898-1-git-send-email-jacmet@sunsite.dk>
	<20090114142135.GA22862@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 14, 2009, at 8:21 AM, Anton Vorontsov wrote:

> Hi Peter,
>
> On Wed, Jan 14, 2009 at 03:14:13PM +0100, Peter Korsgaard wrote:
>> The DMAC IRQ number of the mpc8349 is 71 and not 47, according to
>> http://www.freescale.com/files/32bit/doc/ref_manual/MPC8349EARMAD.pdf
>>
>> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>> ---
>> Documentation/powerpc/dts-bindings/fsl/dma.txt |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/ 
>> Documentation/powerpc/dts-bindings/fsl/dma.txt
>> index cc45311..3df1552 100644
>> --- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
>> +++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
>> @@ -38,7 +38,7 @@ Example:
>> 		reg = <82a8 4>;
>> 		ranges = <0 8100 1a4>;
>> 		interrupt-parent = <&ipic>;
>> -		interrupts = <47 8>;
>> +		interrupts = <71 8>;
>
> 0x47 = 71 ;-) The example is in the dts-v0 format, all the numbers
> are hexadecimal.

I'm all for changing the docs to dts-v1 syntax but if you are going to  
do that.  Do it completely for the file.

(reg, ranges, etc..)

- k
