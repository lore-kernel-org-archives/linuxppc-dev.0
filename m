Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1270DDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:54:01 +1000 (EST)
Date: Tue, 17 Jul 2007 11:53:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: regarding cpm_uart and platform_bus_type
Message-ID: <20070717165347.GE7347@ld0162-tx32.am.freescale.net>
References: <op.tvlxc2sjnhx3hy@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.tvlxc2sjnhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 02:55:30PM +0300, Alexandros Kostopoulos wrote:
> I was wondering, since arch/powerpc is now based on device trees,  
> shouldn't the cpm_uart driver (or at least a branch of it for  
> arch/powerpc) be changed to use of_platform_bus_type instead of  
> platform_bus_type?

Yes.  The patch is on the way Really Soon Now(tm).

-Scott
