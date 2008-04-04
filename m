Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7AF2CDDE3A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 18:50:56 +1100 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080404.154232.-1300528451.kouish@swc.toshiba.co.jp>
References: <20080404.154232.-1300528451.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 18:50:12 +1100
Message-Id: <1207295412.10388.364.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-04 at 15:42 +0900, Ishizaki Kou wrote:
> 
> As you pointed, spider I/O functions in Cell blades need 2 step
> indirections by our patch. Shall I make another one for Cell blades
> whose spider I/O functions need one step indirection?
> (But you will need 2 step indirections when you use PCI-ex.)

I think the blades will need the same stuff as celleb since it's
possible to use the PCI-Express on them too.

Maybe an option is to do a if () / else statement rather than a function
pointer in there, it would at least be cheaper in term of CPU cycle
don't you think ? Anyway, do as you prefer.

Cheers,
Ben.
