Return-Path: <ml@iridescent.org>
Received: from mx0.connactivity.com (mx0.connactivity.com [66.112.160.20])
	by ozlabs.org (Postfix) with ESMTP id B294D67AC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 06:55:01 +1000 (EST)
Mime-Version: 1.0
Message-Id: <p06210215be89c5d708df@mail.iridescent.org>
In-Reply-To: <20050418172532.GB25352@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<p06210211be8997487f7c@mail.iridescent.org>
	<20050418172532.GB25352@gate.ebshome.net>
Date: Mon, 18 Apr 2005 13:54:44 -0700
To: Eugene Surovegin <ebs@ebshome.net>
From: "Lawrence E. Bakst" <ml@iridescent.org>
Content-Type: text/plain; charset="us-ascii"
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 10:25 AM -0700 4/18/05, Eugene Surovegin wrote:
>On Mon, Apr 18, 2005 at 10:01:02AM -0700, Lawrence E. Bakst wrote:
>> I just want to say that in certain applications critical interrupts
>> can be put to good use. There are issues you have to deal with when
>> you use them. I wonder if any of the people saying that they "really
>> don't think it's worth it" have ever had to meet any real time
>> interrupt latency constraints?
>
>You know, it'd help if instead of some general statements, you gave
>real example and explained, why default stuff doesn't work for you.

I'd point out that your own statements were pretty general to start off with. I would have liked to elaborate but unfortunately the work is an ongoing research effort for a client under NDA so I can't say very much.

>Also, it'd be nice if you explained how you dealt with infrastructure
>problems I mentioned in my previous e-mail.

We didn't deal with them as we have a kind of special case. I am not trying to minimize the importance of that issue in the general case.

>
>Answering your question about "real time interrupt latency
>constraints", I have to ask what _exact_ latencies you need, and why
>do you think Linux can provide hard real-time guarantees?

We are trying to get to an interrupt response time of substantially less than what you mention below. In this case "substantially" means between 2 and 3 decimal orders of magnitude.

>
>And yes, I work for company which makes VoIP hardware, and soft
>real-time qualities of 2.4 Linux kernel (preempt, low-lat) are good
>enough for us (~1-5 ms average scheduling latency), without any need
>of critical interrupts.

We're operating in different environments and doing different things. With the kind of response time we're trying to achieve we can't afford to schedule anything.

The only point I was trying to make is that the critical interrupt facility was useful to us. That was it. It's not clear to me that within the constraints of how Linux works, the various infrastructure issues, as well as politics, that it could be made useful to others in a generalized form.

Best,

leb


>
>--
>Eugene
