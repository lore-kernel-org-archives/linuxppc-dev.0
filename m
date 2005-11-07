Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id CC4D9686B0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 01:37:10 +1100 (EST)
In-Reply-To: <20051107084431.GA15180@logos.cnet>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6564e160d322329703e5ab866d98618b@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Mon, 7 Nov 2005 09:35:59 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 7, 2005, at 3:44 AM, Marcelo Tosatti wrote:

> Dan, I wonder why we just don't go back to v2.4 behaviour. It is not 
> very
> clear to me that "two exception" speedup offsets the additional code 
> required
> for "one exception" version. Have you actually done any measurements?

No, and I didn't actually make these changes, either :-)
I'm working on some 8xx debugging right now, so let's experiment
with some changes.  I don't understand why other processors, especially
G2 cores like 82xx, aren't finding the same problems we are having
with 8xx.  Logically, we are all doing the same thing, unless there are
some tlb invalidates on these other processors that I'm forgetting 
about.
We just seem to be running into stale entries, and we have to fix it.

Thanks.

	-- Dan
