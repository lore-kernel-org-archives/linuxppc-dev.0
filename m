Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3760067F22
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 13:11:25 +1000 (EST)
In-Reply-To: <20050805203456.GD14338@dmt.cnet>
References: <20050805203456.GD14338@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <455FDBD7-0511-4EC5-ADE4-E5CF35ABC0F3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 5 Aug 2005 22:11:02 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: [PATCH] cpm_uart: make dpram allocation actually work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 5, 2005, at 3:34 PM, Marcelo Tosatti wrote:

> On Tue, Aug 02, 2005 at 07:09:45PM +0300, Pantelis Antoniou wrote:
>
>>   Hi Marcelo
>>
>> While the idea of allocating console buffers from dpram is sound,
>> the initial implementation didn't actually work :)
>>
>> The following patch fixes it (tested and booted on 2.6.13-rc4).
>>
>
> OK thanks Panto.
>
> Despite my limited knowledge here, Vitaly's merged patch looks fine.
>
> I suppose someone (Kumar?) is going to send it upstream now?

I plan on this, after we test it on 8560.

- kumar
