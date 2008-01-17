Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id DDB78DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:04:13 +1100 (EST)
Message-ID: <478FD118.8030407@semihalf.com>
Date: Thu, 17 Jan 2008 23:05:12 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] Update TQM5200, CM5200 and Motion-PRO _defconfig
	and .dts files
References: <20080117143024.15372.95923.stgit@hekate.izotz.org>	
	<fa686aa40801170805g46eb4686y35c65276779d5244@mail.gmail.com>	
	<478F984F.2030106@semihalf.com>
	<fa686aa40801171023i5188f59btfe41d09711eead09@mail.gmail.com>
In-Reply-To: <fa686aa40801171023i5188f59btfe41d09711eead09@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 1/17/08, Marian Balakowicz <m8@semihalf.com> wrote:
>> Grant Likely wrote:
>>> On 1/17/08, Marian Balakowicz <m8@semihalf.com> wrote:
...
>>> Can you split the defconfig changes into a separate patch...  That
>>> being said, how do you feel about merging all the 5200 defconfigs into
>>> a single defconfig?  They are all multiplatform after all and it would
>>> make maintenance easier.
>> Ok, I'll split it into two patches.
>>
>> But merging defconfigs won't be a good option, boards differ in which
>> devices they use, some have PCI, some have USB, etc. Having one
>> defconfig, it would be necessary to manually customize kernel
>> configuration and remember which options are to be set/disabled.
> 
> That doesn't matter for defconfigs.  That needs to be done when you're
> tailoring a product regardless.  defconfigs are simply a known good
> configuration; they are not intended to be the deployed config.  If
> the defconfig enables all features used by any of the boards then it
> should be okay.

That's true, defconfigs are only reference configurations, but still,
I would opt for a separate defconfigs as it is more clear which target
given defconfig is meant for and it is more convenient for development
and customer to have it separate. And IMHO it's actually easier to
maintain, as you don't need to consider all three boards each time you
update defconfig and don't need to test each defconfig change on three
(right now) boards, etc.

Best Regards,
m.
