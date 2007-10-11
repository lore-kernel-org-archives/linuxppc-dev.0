Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84CA4DDFD4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 00:12:28 +1000 (EST)
In-Reply-To: <18190.3365.54961.935346@cargo.ozlabs.ibm.com>
References: <18190.3365.54961.935346@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <96C1AFB8-784F-445E-A3F2-5D68494541CD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Make clockevents work on PPC601 processors
Date: Thu, 11 Oct 2007 09:12:49 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 11, 2007, at 6:46 AM, Paul Mackerras wrote:

> In testing the new clocksource and clockevent code on a PPC601
> processor, I discovered that the clockevent multiplier value for the
> decrementer clockevent was overflowing.  Because the RTCL register in
> the 601 effectively counts at 1GHz (it doesn't actually, but it
> increases by 128 every 128ns), and the shift value was 32, that meant
> the multiplier value had to be 2^32, which won't fit in an unsigned
> long on 32-bit.  The same problem would arise on any platform where
> the timebase frequency was 1GHz or more (not that we actually have any
> such machines today).

do you still have a 601 running somewhere?

- k
