Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 5D1E32BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 03:04:17 +1000 (EST)
Date: Tue, 28 Sep 2004 10:04:13 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: alebas@televes.com
Message-ID: <20040928100413.C1532@home.com>
References: <1096380738.415971420df80@webmail.televes.com:443>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096380738.415971420df80@webmail.televes.com:443>;
	from alebas@televes.com on Tue, Sep 28, 2004 at 04:12:18PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Full duplex, MDIO and both Ethernet in MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2004 at 04:12:18PM +0200, alebas@televes.com wrote:
> So, is there any plan to merge any of Arabella's changes into the ppc tree? Or
> is there anyone currently working on that ethernet stuff for current 2.4.26
> tree? Is  it planned to provide a patch soon?

Have you asked Arabella what their plans are to submit changes to the
PPC tree? They would be the maintainer of those changes so it's up
to them. It should go into 2.6 first, though, and could go into a
PPC 2.4 tree. Marcelo's 2.4 tree is not taking new features.

-Matt
