Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C648867A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:35:46 +1100 (EST)
Date: Thu, 17 Mar 2005 17:35:26 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050317163526.GB10864@wohnheim.fh-wedel.de>
References: <42323A97.5070105@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <42323A97.5070105@mvista.com>
Cc: linux-mtd@lists.infradead.org, dwmw2@infradead.org,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12] mtd: Remove MTD map file for Chestnut platform.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 11 March 2005 17:40:55 -0700, Mark A. Greer wrote:
> 
> Remove Chestnut mtd map file.
> 
> The chestnut now sets up its MTD map from its platform-specific file so 
> the map file drivers/mtd/maps/chestnut.c is no longer needed.  This 
> patch removes the file & the Kconfig/Makefile hooks.
> 
> Please apply.

Applied to mtd cvs.  It will make its way to Linus eventually...

Thanks!

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
