Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 86566DE00A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 05:01:57 +1100 (EST)
Message-ID: <478F984F.2030106@semihalf.com>
Date: Thu, 17 Jan 2008 19:02:55 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] Update TQM5200, CM5200 and Motion-PRO _defconfig
	and .dts files
References: <20080117143024.15372.95923.stgit@hekate.izotz.org>
	<fa686aa40801170805g46eb4686y35c65276779d5244@mail.gmail.com>
In-Reply-To: <fa686aa40801170805g46eb4686y35c65276779d5244@mail.gmail.com>
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
>> Updates include:
>> - set soc node compatible property to "fsl,mpc5200-immr"
> 
> On these three boards; which have the original mpc5200 and which have
> the mpc5200b?

cm5200 and motionpro have mpc5200b, some versions of tqm5200 have
mpc5200, some have mpc5200b.

> I'm not going to pick up this patch immediately, I've got an invasive
> set of mpc5200 device tree cleanups which need to go in first.  After
> that I'll revisit your changes here.

Understood, thanks.

>> - update i2c device tree nodes
>> - add mdio node
>> - add lpb bus node and flash device (without partitions defined)
>> - add second mscan node for Motio-PRO
>> - add rtc i2c nodes and enable RTC in _defconfigs
>> - use SLUB insteand of SLAB
>> - enable printk timestamp
> 
> Can you split the defconfig changes into a separate patch...  That
> being said, how do you feel about merging all the 5200 defconfigs into
> a single defconfig?  They are all multiplatform after all and it would
> make maintenance easier.

Ok, I'll split it into two patches.

But merging defconfigs won't be a good option, boards differ in which
devices they use, some have PCI, some have USB, etc. Having one
defconfig, it would be necessary to manually customize kernel
configuration and remember which options are to be set/disabled.

Cheers,
m.
