Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id CFD7A679F3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 02:11:47 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 May 2005 01:05:38 +1000."
	<1116255938.5095.133.camel@gaston>
Date: Mon, 16 May 2005 18:11:03 +0200
Sender: wd@denx.de
Message-Id: <20050516161108.5BD3CC1512@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1116255938.5095.133.camel@gaston> you wrote:
>
> I suppose it would add about ... 1 instruction :) Which is probably
> barely measurable compared to the cost of the cache misses of getting to
> the page table entires...

That would be just another "just 1 instruction"  modifircation  to  a
time  critical path in a kernel which already now is so slow compared
against an old 2.4 kernel that I'm really surprised to  nobody  seems
to care.

> But I agree that we don't abolutely _need_ to break everybody. Maybe a
> better compromise would be to have the default beeing per CPU family ?
> 6xx/7xx/7xxx could default to 3G and 8xx stay at 2G...

How many systems actually need this? Why make the <1% of the  systems
that need it the default?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Q: Why do PCs have a reset button on the front?
A: Because they are expected to run Microsoft operating systems.
