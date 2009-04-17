Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5013FDE1B5
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:43:47 +1000 (EST)
Subject: Re: Proposed prom parse fix + moving.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: monstr@monstr.eu
In-Reply-To: <49E81CED.1000704@monstr.eu>
References: <49E81CED.1000704@monstr.eu>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:43:24 +0200
Message-Id: <1239954204.7443.50.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	ilpo.jarvinen@helsinki.fi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 08:08 +0200, Michal Simek wrote:
> Hi All,
> 
> I have got email from Ilpo about prom_parse file.
> I take this file from powerpc. Who did write prom_parse file and take care about?

I wrote it :-)

> BTW: What about to move prom_parse file to any generic location as we discussed in past?
> Any volunteer?

Well.. it relies on some bits and pieces that are rather powerpc
specific afaik such as our irq mapping scheme. I suppose we could split
those bits and move them to a separate file though.

Off hand the patch looks ok but I'll have to look more closely when
I get back from vacation.

Cheers,
Ben.
