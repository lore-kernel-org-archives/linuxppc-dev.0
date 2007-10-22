Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 34BC1DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 11:16:33 +1000 (EST)
Date: Sun, 21 Oct 2007 20:23:27 -0500
From: Olof Johansson <olof@lixom.net>
To: scott.wood@freescale.com, linuxppc-dev@ozlabs.org
Subject: Re: ep88xc_defconfig doesn't build
Message-ID: <20071022012327.GA25490@lixom.net>
References: <20071020024355.GA20356@lixom.net>
	<20071022003625.GC17164@localhost.localdomain>
	<20071022011740.GA25222@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071022011740.GA25222@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 21, 2007 at 08:17:40PM -0500, Olof Johansson wrote:

> A nice enhancement could be to have a "dtc -v" and have the makefile
> verify it before using it.

Looks like current versions do have "-v", my old one didn't. Apologies.


-Olof
