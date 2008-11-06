Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 3F681DDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 12:12:33 +1100 (EST)
Message-ID: <49124480.4030409@consentry.com>
Date: Wed, 05 Nov 2008 17:12:32 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de>
	<20081105233617.GC28465@yookeroo.seuss>
	<49123BB7.90503@consentry.com>
	<20081106005339.GF28465@yookeroo.seuss>
In-Reply-To: <20081106005339.GF28465@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[including extra context because some of the thread went to the
 wrong I2C list]

David Gibson wrote:
> On Wed, Nov 05, 2008 at 04:35:03PM -0800, Mike Ditto wrote:
>> David Gibson wrote:
>> > What does worry me, however, is the description says it's about
>> > whether the driver "should" enable the filter.  Generally the device
>> > tree doesn't attempt to say what users "should" do with the hardware,
>> > just what the characteristics of the hardware are.
>> >
>> > What's the underlying difference here that affects the driver's choice
>> > to enable the filter or not?
>> 
>> I think it's a hardware/environment design parameter - e.g. if the I2C
>> bus has hot-pluggable devices, long PCB traces, or a hierarchy of
>> multiplexed bus segments, these can result in a noisy SCL signal that
>> needs to be filtered.  It's also a recommended mitigation for errata
>> in certain CPU revs.
> 
> Ah, ok.  Well the CPU revision thing could be selected based on the
> CPU revision, but the other conditions are a property of the board
> wiring.  Obviously it's hard to precisely characterize what it says
> about the hardware, which is usually best avoided for devtree
> properties, but I can see why this is more-or-less unavoidable in this
> case.
> 
> Ok.  This property name and meaning looks ok to me.  I would suggest a
> note in the binding roughly explaining what leads to the property
> being set (basically what you just told me in the paragraph above).

Will do.  I'll send a revised patch shortly.

Thanks,
					-=] Mike [=-
