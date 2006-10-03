Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B046B67C1A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 19:40:13 +1000 (EST)
Message-ID: <45222F2D.9020808@s5r6.in-berlin.de>
Date: Tue, 03 Oct 2006 11:36:45 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on	i386
References: <20061002214954.GD665@shell0.pdx.osdl.net>	
	<20061002234428.GE3278@stusta.de>
	<20061003012241.GF3278@stusta.de>	
	<1159850245.5482.32.camel@localhost.localdomain>	
	<20061002214400.0a83b743.akpm@osdl.org>
	<1159850979.5482.40.camel@localhost.localdomain>
In-Reply-To: <1159850979.5482.40.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Judith Lebzelter <judith@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2006-10-02 at 21:44 -0700, Andrew Morton wrote:
>> Net result: lots of new warnings, no fixed bugs.
> 
> Are you sure the warnings won't cause somebody like Al to go through
> them all and fix them ?

If you mean by "fix" to actually convert to generic DMA mapping, then
this task may turn out to require in-depth knowledge of the driver and
its field of application in some or many of these cases.
-- 
Stefan Richter
-=====-=-==- =-=- ---==
http://arcgraph.de/sr/
