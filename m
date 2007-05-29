Return-Path: <dan@embeddedalley.com>
Received: from smtp110.biz.mail.re2.yahoo.com (smtp110.biz.mail.re2.yahoo.com
	[206.190.53.9]) by ozlabs.org (Postfix) with SMTP id 2A910DDF8C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 17:52:55 +1000 (EST)
In-Reply-To: <1180423456.19517.124.camel@localhost.localdomain>
References: <1180423456.19517.124.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 03:52:52 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 3:24 AM, Benjamin Herrenschmidt wrote:

> Hi Folks !
>
> I've been looking at saving & restoring the top 32 bits of 64 bits
> registers when delivering signals to 32 bits processes on a 64 bits
> kernel. The principle is easy, but I wonder where to stick them.

I'm wondering why you need to do this at all?
Why would a 32-bit application care about or
know what to do with these?

Thanks.

	-- Dan
