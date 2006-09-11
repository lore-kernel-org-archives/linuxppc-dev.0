Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FFEE67A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 01:30:27 +1000 (EST)
In-Reply-To: <20060911151730.GA25244@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
	<20060911151730.GA25244@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B0C84ED5-7F7A-4DF4-ADD5-9DB0DF641E42@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Prevent legacy io access on pmac
Date: Mon, 11 Sep 2006 17:30:12 +0200
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> * add check for parport_pc, exit on pmac.
>
> How do I allow parport on PCI cards?

Use the parport_serial driver...  cards that are fixed at the
legacy address probably won't work at all on a PowerMac, the PCI
bridges would have to be set up specially and you'll run into all
kinds of problems.

Cards that have a parport with a configurable base address work
fine in a PowerMac.


Segher
