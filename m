Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 337252BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 06:47:06 +1000 (EST)
In-Reply-To: <20041008194807.GG14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
	<944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008180209.GD14773@smtp.west.cox.net>
	<7079964C-1959-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008194807.GG14773@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85927CE7-196B-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 16:49:17 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 3:48 PM, Tom Rini wrote:

> I don't get it.  We do agree that the very specific stuff does indeed
> belong somewhere that's obvious to the user, right?

I want all of the CPM and 8xx/82xx/85xx configuration to be in
a common menu, just like it is today.  I don't understand the
fascination with syslib/, but if that's where you want things,
that's fine.  Drivers that are common to multiple platforms or
otherwise interact with common subsystems (like uarts and
network drivers) should be in the standard directories.

As the discussion started out earlier today, I also don't like
the configuration options scattered about and in the past
we have discussed this was not to be the case.  Those of
us writing the new code or updating existing code all
thought this was the configuration process, and now today
you are arguing for something different and are likely to
implement it that way against our wishes.  Based upon the
processor type, we should be invoking different Kconfig
scripts that although may use the same sources have different
configuration option criteria.  It is significantly easier for
us to keep those things local for consistent modification,
and I contend will make it easier to focus on the configuration
selections when doing so interactively.

Thanks.


	-- Dan
