Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C60E368866
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 01:15:17 +1100 (EST)
In-Reply-To: <20051201121711.GA4105@dmt.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
	<20051123120033.GA3551@logos.cnet>
	<6B29BC5F-3B18-4EEE-B70C-215A2C540C85@kernel.crashing.org>
	<20051201121711.GA4105@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7a226eed748ae0475cc58b0ad4708d53@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 1 Dec 2005 09:15:00 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 1, 2005, at 7:17 AM, Marcelo Tosatti wrote:

> snd/ I think... Someone needs to test the driver. I think we should 
> just
> fixup the syntactical problems and mark it as BROKEN until someone 
> (Dan?)
> confirms it works.

Since I'm probably the only one left in the world with this
hardware, it probably doesn't make sense to keep it around.
I know people have used it in the past as an example of how
to program the TDM on the 8xx, but it's not necessary to keep
it around for that reason.

Thanks.

	-- Dan
