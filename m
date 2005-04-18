Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2C83F67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 03:25:35 +1000 (EST)
Date: Mon, 18 Apr 2005 10:25:32 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Lawrence E. Bakst" <ml@iridescent.org>
Message-ID: <20050418172532.GB25352@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<p06210211be8997487f7c@mail.iridescent.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p06210211be8997487f7c@mail.iridescent.org>
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

On Mon, Apr 18, 2005 at 10:01:02AM -0700, Lawrence E. Bakst wrote:
> I just want to say that in certain applications critical interrupts 
> can be put to good use. There are issues you have to deal with when 
> you use them. I wonder if any of the people saying that they "really 
> don't think it's worth it" have ever had to meet any real time 
> interrupt latency constraints?

You know, it'd help if instead of some general statements, you gave 
real example and explained, why default stuff doesn't work for you.

Also, it'd be nice if you explained how you dealt with infrastructure 
problems I mentioned in my previous e-mail.

Answering your question about "real time interrupt latency 
constraints", I have to ask what _exact_ latencies you need, and why 
do you think Linux can provide hard real-time guarantees? 

And yes, I work for company which makes VoIP hardware, and soft 
real-time qualities of 2.4 Linux kernel (preempt, low-lat) are good 
enough for us (~1-5 ms average scheduling latency), without any need 
of critical interrupts.

-- 
Eugene
