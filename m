Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 34D30DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 12:19:28 +1000 (EST)
Date: Tue, 19 Jun 2007 21:27:53 -0500
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
Message-ID: <20070620022753.GA27219@lixom.net>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
	<20070620020211.GO9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070620020211.GO9768@bakeyournoodle.com>
From: olof@lixom.net (Olof Johansson)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 12:02:11PM +1000, Tony Breeds wrote:
> On Tue, Jun 19, 2007 at 09:53:56AM -0500, Olof Johansson wrote:
>  
> > It only seems to be used in this file, so it can be static, right?
> 
> True, I was following suit with tb_to_ns_scale, tb_to_ns_shift which
> could also be static.

I wasn't sure of those since I was only looking at the patch in question,
not the full source file. But yes, that's the right thing to do.

> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
