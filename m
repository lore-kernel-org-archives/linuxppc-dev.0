Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 9A988B7D12
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 03:45:40 +1000 (EST)
Received: by wyf19 with SMTP id 19so359273wyf.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 10:45:38 -0700 (PDT)
Date: Fri, 30 Apr 2010 21:45:34 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
Message-ID: <20100430174534.GA31083@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
	<20100312130723.43308ccd.akpm@linux-foundation.org>
	<fa686aa41003121338oe34eb89o22177cb0a309cc85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa41003121338oe34eb89o22177cb0a309cc85@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 12, 2010 at 02:38:02PM -0700, Grant Likely wrote:
[...]
> How to proceed:  I'd like to leave this series out for the 2.6.34
> cycle and I'll pick it into my OF tree before the 2.6.35 merge window,
> but I'll probably modify it to call the OF hooks directly and leave
> out the unnecessary notifier infrastructure.

Ping?
