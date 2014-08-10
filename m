Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 7A8131A09B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 04:42:45 +1000 (EST)
Message-ID: <53E7BD21.6010301@roeck-us.net>
Date: Sun, 10 Aug 2014 11:42:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] net: ugg_geth: Fix build error in -next
References: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
 <20140810183622.GC5134@pengutronix.de>
In-Reply-To: <20140810183622.GC5134@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2014 11:36 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Sun, Aug 10, 2014 at 09:19:14AM -0700, Guenter Roeck wrote:
>> powerpc:mpc83xx_defconfig and other builds fail with
>>
>> drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_remove':
>> drivers/net/ethernet/freescale/ucc_geth.c:3927:19: error:
>> 	'struct ucc_geth_private' has no member named 'info'
>>    of_node_put(ugeth->info->tbi_node);
>>                       ^
>> drivers/net/ethernet/freescale/ucc_geth.c:3928:19: error:
>> 	     'struct ucc_geth_private' has no member named 'info'
>>    of_node_put(ugeth->info->phy_node);
>>    		     ^
>>
>> Introduced by commit "net: ucc_geth: drop acquired references in probe error
>> path and remove".
>>
>>  From the context, it appears that the variable is named ug_info.
>>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Only seen in -next.
> My patch was only sent just now, but it has the subject right:
>
Excellent.

> 	http://mid.gmane.org/1407695525-32227-1-git-send-email-u.kleine-koenig@pengutronix.de
>
The link doesn't seem to work for some reason.

> Another upside is that it contains a Fixes: header.
>
Even better. I need to start using that.

> Other than that my patch is the same. In case davem picks up yours:
>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>

I don't need the glory ;-). Dave, please pick Uwe's patch.

Thanks,
Guenter
