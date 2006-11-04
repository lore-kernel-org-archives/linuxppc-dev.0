Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 4EEAE67C27
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 04:26:27 +1100 (EST)
In-Reply-To: <1162632114.28571.33.camel@localhost.localdomain>
References: <1162632114.28571.33.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6417E0BC-ADFA-45D2-9780-95453E7DC15A@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: FSL vs. IBM BookE
Date: Sat, 4 Nov 2006 12:24:03 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 4, 2006, at 4:21 AM, Benjamin Herrenschmidt wrote:

> How bad are the differences between those cores ?

They are getting more different as the product families
evolve.    The common instruction paths are growing
smaller, and I think the amount of #ifdefs and patching
will make the code much more complex that just leaving
as it is.

> ...  Would it be possible
> to reconcile those and IBM 44x into a single processor family ?

I don't think it's worth while.  The amount of code isn't
that great and the differences outweigh the similarities.

> Also, I suppose we should rename head_4xx.S to head_40x.S no ?

Maybe, but we all know what they are :-)

Thanks.

	-- Dan
