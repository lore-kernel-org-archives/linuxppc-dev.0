Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E559ADE013
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:14:18 +1100 (EST)
Message-ID: <47858D89.4070706@pikatech.com>
Date: Wed, 09 Jan 2008 22:14:17 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
	<20080110024753.GC17816@localhost.localdomain>
In-Reply-To: <20080110024753.GC17816@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Jan 09, 2008 at 03:21:07PM -0500, Sean MacLennan wrote:
>   
>> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
>> ---
>> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
>> +++ arch/powerpc/boot/dts/warp.dts	2008-01-08 12:04:10.000000000 -0500
>>     
>
> [snip]
>   
>> +	plb {
>> +		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +		clock-frequency = <0>; /* Filled in by zImage */
>> +
>> +		SDRAM0: sdram {
>> +			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
>> +			dcr-reg = <010 2>;
>> +		};
>> +
>> +		DMA0: dma {
>> +			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
>> +			dcr-reg = <100 027>;
>> +		};
>> +
>> +		FPGA0: fpga {
>>     
>
> Surely this must be off the EBC, not directly of the PLB...?
>   
Could be, I don't really know :( I will move it if it makes more sense.

Cheers,
    Sean
