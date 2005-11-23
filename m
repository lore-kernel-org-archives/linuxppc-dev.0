Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F06D7687FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 05:42:18 +1100 (EST)
Date: Wed, 23 Nov 2005 16:25:51 -0200
From: 'Aristeu Sergio Rozanski Filho' <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051123182551.GB7163@cathedrallabs.org>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
	<20051123120033.GA3551@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051123120033.GA3551@logos.cnet>
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

> However there are some PHY descriptions in fec.c which are missing from
> fs_enet - we'd better make sure to have them all in the new driver
> before removing the old one.
> 
> Aris, would you mind looking into this?
I'm on it

--
Aristeu
