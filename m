Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C490DDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:33:35 +1000 (EST)
Message-ID: <4703C454.4060804@freescale.com>
Date: Wed, 03 Oct 2007 11:33:24 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to	the
	QE library
References: <11903212461510-git-send-email-timur@freescale.com>
	<20071003133032.GA2417@localhost.localdomain>
	<4703A453.8080305@freescale.com>
	<20071003143417.GA5123@localhost.localdomain>
	<4703AEDC.1050902@freescale.com>
	<20071003162900.GA30091@localhost.localdomain>
In-Reply-To: <20071003162900.GA30091@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>>  struct ucc_geth {
>>  	struct ucc_fast uccf;
>> +	u8	res9[0x100 - sizeof(struct ucc_fast)];
>>  	u32 maccfg1;		/* mac configuration reg. 1 */
>>  	u32 maccfg2;		/* mac configuration reg. 2 */
>>
> 
> This fixed issue, much thanks.

Great!  I'm very sorry about introducing that bug.  I guess I didn't really 
test it on 8360 after all.  I just thought I did.

I'm sending v4 of this patch out now.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
