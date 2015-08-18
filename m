Return-Path: <javier@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id C48081A0239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 20:35:17 +1000 (AEST)
Subject: Re: [05/27] macintosh: therm_windtunnel: Export I2C module alias
 information
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
References: <20150818102449.06B531406A9@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <55D30A5F.105@osg.samsung.com>
Date: Tue, 18 Aug 2015 12:35:11 +0200
MIME-Version: 1.0
In-Reply-To: <20150818102449.06B531406A9@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On 08/18/2015 12:24 PM, Michael Ellerman wrote:
> On Thu, 2015-30-07 at 16:18:30 UTC, Javier Martinez Canillas wrote:
>> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
>> regardless if the driver was matched using the I2C id_table or the
>> of_match_table. So the driver needs to export the I2C table and this
>> be built into the module or udev won't have the necessary information
>> to auto load the correct module when the device is added.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>  drivers/macintosh/therm_windtunnel.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Who are you expecting to merge this?
> 

I was expecting Benjamin Herrenschmidt since he is listed in MAINTAINERS
for drivers/macintosh. I cc'ed him in the patch but now in your answer I
don't see him in the cc list, strange.

But I'll be happy to re-post if there is another person who is handling
the patches for this driver now.

BTW there is another patch [0] for the same driver to export the OF id
table information, that was not picked either.

> cheers
> 

[0]: https://lkml.org/lkml/2015/7/30/503

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
