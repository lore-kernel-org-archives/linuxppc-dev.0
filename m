Return-Path: <kaloz@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [195.56.146.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84E7BDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 00:54:16 +1100 (EST)
Date: Thu, 07 Feb 2008 14:54:05 +0100
To: "Valentine Barshak" <vbarshak@ru.mvista.com>, "Josh Boyer"
	<jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] MTD support for the AMCC Taishan
From: "Imre Kaloz" <kaloz@openwrt.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
References: <120203530465-git-send-email-kaloz@openwrt.org>
	<op.t55gr5lb2s3iss@ecaz.afh.b-m.hu>
	<20080207060012.788e4258@zod.rchland.ibm.com>
	<47AB0BC3.2000202@ru.mvista.com>
Message-ID: <op.t55p8elk2s3iss@ecaz.afh.b-m.hu>
In-Reply-To: <47AB0BC3.2000202@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, arch/ppc calculates the mtd2 dynamically and doesn't create
a separate partition for kozio.

I've based this on how it's currently done for the Sequoia, too.


Imre

On Thu, 07 Feb 2008 14:46:43 +0100, Valentine Barshak  
<vbarshak@ru.mvista.com> wrote:

> Josh Boyer wrote:
>> On Thu, 07 Feb 2008 11:29:55 +0100
>> "Imre Kaloz" <kaloz@openwrt.org> wrote:
>>
>>> *bump*? :) If anything is wrong with it, please let me know.
>
> The arch/ppc had a bit different partition table.
> Something like this:
> mtd0: 00180000 00040000 "kernel"
> mtd1: 00200000 00040000 "root"
> mtd2: 03bc0000 00040000 "user"
> mtd3: 00080000 00040000 "env"
> mtd4: 00040000 00040000 "u-boot"
>
> Thanks,
> Valentine.
>
>>  Nothing wrong that I could see.  I just need to test it first.
>>  josh
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
