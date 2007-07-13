Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 659EEDDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 02:10:14 +1000 (EST)
Subject: Re: [PATCH 4/5] move 86xx into multiplatform
From: Jon Loeliger <jdl@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20070712210909.451536561@arndb.de>
References: <20070712210156.973038514@arndb.de>
	<20070712210909.451536561@arndb.de>
Content-Type: text/plain
Message-Id: <1184343006.3655.36.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 13 Jul 2007 11:10:06 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-12 at 16:02, Arnd Bergmann wrote:
> MPC86xx based machines don't need their own kernel,
> but can run one that is shared with the other 6xx
> compatible machines, so we should allow that
> in Kconfig.
> 
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Kumar, I don't remember if you still had objections
> to merging 86xx annd 83xx into multiplatform after
> our last discussion.
> Please Ack or Nack the two patches.


Hmmm... Shouldn't this sort of change come
with an update to the 8641 defconfig too?

jdl
