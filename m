Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C9E8DE0D6
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 07:45:05 +1000 (EST)
Message-Id: <7CA29A12-6DC4-4939-9541-6270FE5D910A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200809192328.36159.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Fix Book-E watchdog timer interval setting
Date: Fri, 19 Sep 2008 16:44:40 -0500
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<A4CCB071-0FCE-490A-B563-399FCA74C71E@kernel.crashing.org>
	<200809192328.36159.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please repost and I'll look at it again.. I'm trying to be more  
diligent about patchworks.ozlabs.org and tracking things there.

- k

On Sep 19, 2008, at 4:28 PM, Matthias Fuchs wrote:

> Hi Kumar,
>
> should I resend this my patch? Is there chance to get it applied.
> It really fixes a bug!
>
> Matthias
>
> On Thursday 07 August 2008 15:19:10 Kumar Gala wrote:
>> On Aug 7, 2008, at 7:48 AM, Matthias Fuchs wrote:
>>> This patch fixes the setting of the Book-E watchdog timer interval
>>> setup
>>> on initialization and by ioctl().
>>>
>>> Tested on PPC440EPx sequoia evaluation board.
>>>
>>> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
>>> ---
>>> drivers/watchdog/booke_wdt.c |    6 +++++-
>>> 1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> can you be more explicit about what the bug was.
>>
>> - k
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
