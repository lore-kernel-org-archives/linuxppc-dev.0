Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id CEF77DE06F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 03:25:44 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <20090126092605.GB28453@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090125194853.GB26917@pengutronix.de>
	<fa686aa40901251746x644e22c6tf8862103c04db1dc@mail.gmail.com>
	<20090126092605.GB28453@pengutronix.de>
Date: Tue, 27 Jan 2009 09:25:43 -0700
Message-ID: <fa686aa40901270825i7bfb8142y95dbb441413c4b72@mail.gmail.com>
Subject: Re: [PATCH 1/8] powerpc/5200: update device tree binding
	documentation
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devtree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 26, 2009 at 2:26 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> >> +system-frequency     Fsystem frequency; source of all
>> >
>> > Fsystem? Typo?
>>
>> Not really, that's the name of the clock in the MP5200 user guide.
>> I'll clarify what I've written here though.
>
> That will be helpful.
>
>> > The unit would be nice here, too, I think.
>>
>> Unit?  Do you mean stating that it is in Hz?
>
> Yes, like in the frequency next to it.
>
> Kind regards,
>
>   Wolfram
>
> PS: The other patches look good to me, too. I just want to test them on
> a real phyCORE-tiny this week.

Thanks,

I want to get these queued up into -next ASAP, so let me know when
you've had a chance to try them.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
