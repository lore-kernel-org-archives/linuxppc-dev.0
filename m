Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6B0568612
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 14:09:29 +1000 (EST)
In-Reply-To: <a1a7967e0510191729x520b2aeak@mail.gmail.com>
References: <434BC424.50700@ru.mvista.com> <20051018142411.GA14065@logos.cnet>
	<4c41159c3c06e288e5d69469f1e3ce7b@embeddededge.com>
	<a1a7967e0510191729x520b2aeak@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2a23feda92d83753d9f74cf157d9b0fd@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 20 Oct 2005 00:15:02 -0400
To: Christopher Cordahi <christopher.cordahi@gmail.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 19, 2005, at 8:29 PM, Christopher Cordahi wrote:

> I don't understand in what way Marcelo wants to use it, but
> from my understanding and a quick look of the Freescale product
> summary pages it's the opposite of what you're indicating.

OK.  I can't find an up to date one any more.  From the processor
manuals there are overlapping numbers (unless that was just
an oversight during editing).

> Also just because a feature isn't supposed to be present
> doesn't mean it's not.

Yeah, some people have tried probing peripherals to discover
the type of processor, but that was quickly proven to not work.

Thanks.

	-- Dan
