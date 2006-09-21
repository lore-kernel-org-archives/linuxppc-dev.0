Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2CE8E67B7C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 06:38:28 +1000 (EST)
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9399B44EF@tmnt04.transmode.se>
References: <F6AD7E21CDF4E145A44F61F43EE6D9399B44EF@tmnt04.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <850F8461-05C3-487A-985E-EC91141CE2AD@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 4/11] qe_lib: Add QE I/O ports API
Date: Thu, 21 Sep 2006 15:38:22 -0500
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
>> +static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] = {
>> +	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /*
>> 24 - 31 */
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0,
>> 0,0,0,0,0,1,1,0},
>> +	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,
>> 0,0,1,1,0,0,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
>> 0,0,0,1,1,1,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0,
>> 0,0,1,1,0,0,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,
>> 1,1,1,1,0,0,0,1},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0,
>> 0,0,0,0,0,0,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
>> 0,0,0,0,0,0,0,1}
>> +};
>
> qe_irq_ports is diffrent on 8321 not only the number of rows.
>
> These needs to configuruable based on CPU model and/or type of board.

That sounds like a job for the DTS
