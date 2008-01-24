Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 625D8DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 07:24:16 +1100 (EST)
Date: Thu, 24 Jan 2008 14:24:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH UCC TDM 1/3 Updated] Platform changes for UCC TDM
	driver for MPC8323eRDB. Also includes related QE changes and dts
	entries.
Message-ID: <20080124202420.GC3926@loki.buserror.net>
References: <Pine.LNX.4.64.0801241553270.4984@linux121>
	<20080124154804.GA22178@localhost.localdomain>
	<4798B4F3.2010101@freescale.com>
	<20080124162345.GA27359@localhost.localdomain>
	<4798BDEB.2010501@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4798BDEB.2010501@freescale.com>
Cc: Poonam_Aggrwal-b10812 <b10812@freescale.com>,
	michael.barkowski@freescale.com, netdev@vger.kernel.org,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	rubini@vision.unipv.it, linuxppc-dev@ozlabs.org,
	ashish.kalra@freescale.com, rich.cutler@freescale.com,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 10:33:47AM -0600, Timur Tabi wrote: Yes, but
> deciding what the UCC does might not be static.  At what point do we
> declare, "UCC5 is for eth0 and eth0 only"?

When the board designer decides to hook eth0 up to UCC5.

If the board designer decides to hook multiple devices up to UCC5, we first
smack the board designer, and then set it up to whichever configuration has
been jumpered.

-Scott
