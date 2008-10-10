Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3ECDDDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 06:42:21 +1100 (EST)
Message-ID: <48EFB025.6050808@billgatliff.com>
Date: Fri, 10 Oct 2008 14:42:29 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
	<Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
	<48EF5FAC.1060807@billgatliff.com>
	<20081010174003.GC10579@linux-sh.org>
In-Reply-To: <20081010174003.GC10579@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mundt wrote:
>> Hasn't been a problem so far.  I posted the first version of the code on l-a-k,
>> and got some feedback on the pwm_device API and a lot of feedback on the way
>> users wanted to use the API to realize applications.  I incorporated all of it,
>> and in this "release" I broadened the exposure per recommendations received from
>> l-a-k.
>>
> This is precisely the problem. Stuff that gets "reviewed" on
> linux-arm-kernel gets reviewed for ARM only. There has been way too much
> crap that has been pushed into the kernel under the guise of being
> generic and "reviewed" that has broken _every_ architecture _except_ ARM.
> If you want to refute this, go look at the recent fiasco with musb, which
> still hasn't been solved properly, primarily because the ARM people
> couldn't be bothered using grep. This crap happens all the time, because
> stuff is reviewed and merged in private, and the only time anyone else
> notices is when their platform suddenly stops building.

I'll note for the record that I didn't post on linux-arm-kernel only.
Otherwise, we wouldn't be having this discussion.  :)

> Your first version should have been to linux-embedded and linux-kernel.
> If you want to alert the linux-arm-kernel people to the fact that a
> discussion is going on in this area, then feel free to post a
> notification to the list with references to the relevant lists. There is
> no reason why public lists should have to dig in to private archives to
> try and play catch up.

I'm not asking anyone to do that.  Just review the patches posted to the list of
your choice.  Or, don't review them.  Up to you.

My next update will be the one where I formally request a review with intent to
merge into mainline.  That one will go to linux-embedded only, with
notifications sent elsewhere as indicated per community request.  I don't have a
problem with that.  I can't change history, but I'm doing what you are asking of
me otherwise.

> If you're trying to pitch a generic API and doing your review on a
> private list, you've already lost. If you're talking about things that
> only effect arch/arm, feel free to do whatever you want. As soon as you
> step outside of that structure, you have to follow common convention, or
> you risk breaking things all over the place. I can't remember the last
> time I saw a "generic" API reviewed on linux-arm-kernel that didn't end
> up breaking every other architecture in existence. This is true for
> drivers, also. Better yet, don't bother dropping the ARM depedency until
> you've posted to a public list.

Again, we wouldn't be having this exchange if I was pitching a generic API on a
private list because I sense that you aren't an l-a-k subscriber.  :)

It's true that the early posts were on the ARM list, but you can see that I
didn't stop there.  I started there because the platform that supports the API
right now is ARM, and so I wanted that part to be right before moving upstream.
 That process worked: I received feedback on the ARM-specific bits which
improved the API as a whole.  The diversity of ARM machines plus Blackfin, PPC,
MIPS, X, Y, Z and PDQ machines was more than I could deal with until now.

Right, enough of that.  I really don't want to get distracted from the code.
I'll readily admit to not handing the mailing list submissions right, and I
resolve to do a better job effective immediately.  But I think that's the last
that I need to say on the subject.

If it makes you feel any better, I'll stop responding to your replies unless
they come to me via linux-embedded.  :)

> Some of us are pretty damn tired of cleaning up after the ARM people.

Sounds like the ARM people need you to drop by and help them do a better job.
Sounds like you could directly benefit from their doing a better job, too.  Win-win.




b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
