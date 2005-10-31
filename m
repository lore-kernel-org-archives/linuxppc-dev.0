Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai19.cox.net (fed1rmmtai19.cox.net [68.230.241.40])
	by ozlabs.org (Postfix) with ESMTP id 6AB4E68646
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Nov 2005 02:05:23 +1100 (EST)
Date: Mon, 31 Oct 2005 07:41:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
Message-ID: <20051031074135.D11144@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509301452.52074.sr@denx.de> <200510281758.56646.sr@denx.de>
	<200510311029.13432.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510311029.13432.sr@denx.de>;
	from sr@denx.de on Mon, Oct 31, 2005 at 11:29:13AM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: Add missing initrd header on ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 31, 2005 at 11:29:13AM +0200, Stefan Roese wrote:
> By the way: What is the current status of the pending 4xx patches. Are they 
> going in in this 2-week merge window?

The PPC44x U-Boot cleanup was queued and merged.  The rest of PPC4xx
cleanup patches are now pending with akpm and will probably be queued
for Linus shortly. There will be no problem with them being merged.

-Matt
