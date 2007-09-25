Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 50D76DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 11:38:40 +1000 (EST)
Date: Mon, 24 Sep 2007 20:41:32 -0500
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Make instruction dumping work in real mode.
Message-ID: <20070925014132.GA31979@lixom.net>
References: <20070924190100.GB4761@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070924190100.GB4761@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 02:01:00PM -0500, Scott Wood wrote:
> On non-book-E, if a faulting PC is in the first few pages, and it's not an
> ITLB miss, it's likely executing in real mode, probably at an exception vector.
> 
> Rather than print a useless XXXXXXXX, it is assumed that this is the case, and
> the address is treated as physical.  This helps when debugging corruption at
> the beginning of memory.

Please use regs->msr & MSR_IR instead.


-Olof
