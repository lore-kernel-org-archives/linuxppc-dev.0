Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4BEB67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 05:32:34 +1100 (EST)
Date: Thu, 17 Mar 2005 19:32:18 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Josh Boyer <jdub@us.ibm.com>
Message-ID: <20050317183218.GC11836@wohnheim.fh-wedel.de>
References: <42323A97.5070105@mvista.com>
	<20050317163526.GB10864@wohnheim.fh-wedel.de>
	<4239C51B.70101@mvista.com>
	<1111083871.7610.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1111083871.7610.3.camel@windu.rchland.ibm.com>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
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

On Thu, 17 March 2005 12:24:31 -0600, Josh Boyer wrote:
> 
> Jörn meant that the next time the MTD BK tree is synced with Linus,
> it'll show up.  If it's already there, then no big deal :).

Not for me at least. ;)

Bk could automatically detect if the same changeset went in through
different trees.  From cvs, it may give dwmw2 a slight headache.

Jörn

-- 
tglx1 thinks that joern should get a (TM) for "Thinking Is Hard"
-- Thomas Gleixner
