Return-Path: <christian@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 08FA3B6FEE
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:52:47 +1000 (EST)
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <20120419113723.03a24d46@endymion.delvare>
In-Reply-To: <20120419113723.03a24d46@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Christian Kujau <christian@nerdbynature.de>
Date: Thu, 19 Apr 2012 11:36:10 +0200
To: Jean Delvare <khali@linux-fr.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <089f2503-3796-4c5b-8620-d2498fc755be@email.android.com>
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jean Delvare <khali@linux-fr.org> wrote:

>On Thu, 19 Apr 2012 18:16:41 +1000, Benjamin Herrenschmidt wrote:
>> The goal of this series is to convert a bulk of PowerMac i2c drivers
>> to the new "proper" i2c driver registration model. This series is
>> not complete in that there are still a few drivers to do but it
>> goes through the bulk of thermal control and some of the nastiest.
>> 
>> The biggest change is that windfarm is ported to generally use
>> the new model, and I've written a new set of windfarm modules to
>> take over from the old therm_pm72 (which was mostly unfixable)
>> on the PowerMac G5 AGP and Xserve G5 machines.
>> 
>> This had a bit of testing on a couple of PowerMac G5 AGP variants
>> but none at all on Xserve G5 since the one I have is unfortunately
>> dead.
>> 
>> If you want to help me test this, don't forget to disable therm_pm72,
>> and instead load windfarm_pm72 or windfarm_rm31 depending on your
>> machine (you can load or build-in the whole lot as well). As usual
>> windfarm don't properly auto-load yet, I still need to fix that.
>> 
>> So please test ! Especially if you have an XServe G5
>
>Benjamin, thanks a lot for doing this! These drivers were the last ones
>blocking the removal of the legacy binding model in i2c-core. Testers
>are very welcome. The earliest we can get these changes upstream, the
>better.
>
>Christian, can you please test this series? I'm sure Benjamin can send
>the patches to you directly if needed.
>
>-- 
>Jean Delvare

I may need a day or two to get to it, but I'll test it.

Thanks,
C.
-- 
make bzImage, not war
