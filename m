Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id CCD0D67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 05:20:58 +1100 (EST)
Message-ID: <42387908.5010003@timesys.com>
Date: Wed, 16 Mar 2005 13:20:56 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42386274.2020504@timesys.com>
	<f37ebc53776184342f4eb01eb23efcac@freescale.com>
In-Reply-To: <f37ebc53776184342f4eb01eb23efcac@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [patch] fix unitilized spinlock in cpm driver when used as
	console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> This may already be resolved by this patch which is in the latest bk 
> tree.
>
> http://ozlabs.org/ppc32-patches/patch.pl?id=280
>
> - kumar
>
> On Mar 16, 2005, at 10:44 AM, Greg Weeks wrote:
>
>> Fix unitilized spinlock in the cpm scc driver when used as console.
>>
>> Signed-off-by: Greg Weeks <greg.weeks@timesys.com>
>>
>>  <cpm.console.spinlock.patch><ATT247771.txt>
>
>
Yes that fixes it.

Greg Weeks
