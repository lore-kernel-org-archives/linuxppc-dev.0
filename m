Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 489AD2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 16:59:51 +1000 (EST)
Date: Mon, 27 Sep 2004 23:59:48 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Gardiner <daveg@sonartech.com.au>
Message-ID: <20040927235948.G30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
	<415908DC.3090409@sonartech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <415908DC.3090409@sonartech.com.au>;
	from daveg@sonartech.com.au on Tue, Sep 28, 2004 at 04:46:52PM
	+1000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2004 at 04:46:52PM +1000, David Gardiner wrote:
> so where do I look ??? I'm thinking it's in the mvme5100 platform setup, 
> am I assuming right?
 
Yes, mvme5100_map_irq() is what you want. Comparing 2_4_devel to 2.6,
only the PMCSPAN IDSEL routing is missing. Don't know what your 2.4
kernel looks like or your current map in your 2.6 port.

-Matt
