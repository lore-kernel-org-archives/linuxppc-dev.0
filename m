Return-Path: <javier@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id A218A1A0514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 17:40:50 +1000 (AEST)
Subject: Re: [05/27] macintosh: therm_windtunnel: Export I2C module alias
 information
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20150818102449.06B531406A9@ozlabs.org>
 <55D30A5F.105@osg.samsung.com> <1439945515.23217.6.camel@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <55D432FC.2010005@osg.samsung.com>
Date: Wed, 19 Aug 2015 09:40:44 +0200
MIME-Version: 1.0
In-Reply-To: <1439945515.23217.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On 08/19/2015 02:51 AM, Michael Ellerman wrote:
> On Tue, 2015-08-18 at 12:35 +0200, Javier Martinez Canillas wrote:
>> Hello Michael,
>>
>> On 08/18/2015 12:24 PM, Michael Ellerman wrote:
>>> On Thu, 2015-30-07 at 16:18:30 UTC, Javier Martinez Canillas wrote:
>>>> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
>>>> regardless if the driver was matched using the I2C id_table or the
>>>> of_match_table. So the driver needs to export the I2C table and this
>>>> be built into the module or udev won't have the necessary information
>>>> to auto load the correct module when the device is added.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>> ---
>>>>
>>>>  drivers/macintosh/therm_windtunnel.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>
>>> Who are you expecting to merge this?
>>>
>>
>> I was expecting Benjamin Herrenschmidt since he is listed in MAINTAINERS
>> for drivers/macintosh. I cc'ed him in the patch but now in your answer I
>> don't see him in the cc list, strange.
> 
> That's the mailing list dropping him from CC because he's subscribed.
> 
>> But I'll be happy to re-post if there is another person who is handling
>> the patches for this driver now.
>>
>> BTW there is another patch [0] for the same driver to export the OF id
>> table information, that was not picked either.
> 
> Yep, I'll grab them both.
>

Perfect, thanks a lot!
 
> cheers
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
