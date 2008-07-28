Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DFFEDE4AC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 04:31:03 +1000 (EST)
Date: Mon, 28 Jul 2008 13:30:43 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Sparks, Sam" <SSparks@aclaratech.com>
Subject: Re: mpc8349-mITX DTB load failure
Message-Id: <20080728133043.563a691c.kim.phillips@freescale.com>
In-Reply-To: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
References: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 11:10:47 -0500
"Sparks, Sam" <SSparks@aclaratech.com> wrote:

> ## Booting kernel from Legacy Image at 01001000 ...

> ## Flattened Device Tree blob at 01000000

so the dtb is being loaded only 0x1000 bytes from the kernel, yet it's
probably bigger than that.  Can you try different load addresses,
preferably with the two images at least 0x3000 bytes apart?

Kim
