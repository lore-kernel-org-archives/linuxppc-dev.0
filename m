Return-Path: <rdunlap@xenotime.net>
Received: from oproxy7-pub.bluehost.com (oproxy7.bluehost.com
 [IPv6:2605:dc00:100:2::a7])
 by ozlabs.org (Postfix) with SMTP id 990C4B6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 07:47:43 +1100 (EST)
Message-ID: <4F0E017B.9060602@xenotime.net>
Date: Wed, 11 Jan 2012 13:39:07 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 0/14] Finish up irq_domain generalization
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/11/2012 12:22 PM, Grant Likely wrote:
> Here are the patches that I've been working on to finish up the creation
> of the generic irq_domain infrastructure.

Does this fix the linux-next build problems that I have reported?

https://lkml.org/lkml/2012/1/9/318


>  kernel/irq/irqdomain.c                           |  733 ++++++++++++++++++----

thanks,
-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
