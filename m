Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id AFC2DDE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 16:21:22 +1100 (EST)
Message-ID: <4786FCD0.5020100@pikatech.com>
Date: Fri, 11 Jan 2008 00:21:20 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
	<20080110024753.GC17816@localhost.localdomain>
	<4786B147.5070206@pikatech.com>
	<20080111002037.GB23402@localhost.localdomain>
In-Reply-To: <20080111002037.GB23402@localhost.localdomain>
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
> On Thu, Jan 10, 2008 at 06:59:03PM -0500, Sean MacLennan wrote:
>   
>> New version with recommended changes. Device types removed. FPGA
>> moved to correct bus.
>>     
>
> [snip]
>   
>> +				fpga@2,0 {
>> +					compatible = "pika,fpga";
>> +			   		reg = <0 80000000 2200>;
>>     
>
> Your reg property doesn't match your node name here...
>   
Is the following correct?

				fpga@2,0 {
					compatible = "pika,fpga";
			   		reg = <2 80000000 2200>;
					interrupts = <18 8>;
					interrupt-parent = <&UIC0>;
				};


Cheers,
   Sean
