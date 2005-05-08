Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C21C7679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 11:10:53 +1000 (EST)
In-Reply-To: <20050506154539.GA6452@logos.cnet>
References: <20050506154539.GA6452@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <52dc3ae70f883699b1e48b7d742afcaf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 21:10:17 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: How to fix 8xx dcbst bug?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 6, 2005, at 11:45 AM, Marcelo Tosatti wrote:

>
> Hi Dan,
>
> So, restarting this conversation...

One of the things I don't want to lose sight of during
all of this is the real performance problem in 2.6.
Your test results show there is something that needs
attention, regardless of using pinned entries.  We
need to continue some of this investigation, it
affects all processors.

Thanks.

	-- Dan
