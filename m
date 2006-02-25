Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 823A467B97
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Feb 2006 08:09:26 +1100 (EST)
Subject: Re: [PATCH] processes stuck forever in __do_get_xsec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060225102730.GA17550@suse.de>
References: <20060225102730.GA17550@suse.de>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 08:09:22 +1100
Message-Id: <1140901762.24957.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-02-25 at 11:27 +0100, Olaf Hering wrote:
> 64bit processes loop forever in __do_get_xsec, r8 is loaded, but r4 is compared.
> Also, gdb doesnt understand __do_get_xsec and __get_datapage.
> 
> No idea if my change is correct.

Good catch ! I send a better patch for it.

Ben.
