Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 812CFB6FD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 07:00:09 +1100 (EST)
Date: Mon, 27 Feb 2012 14:57:53 -0500 (EST)
Message-Id: <20120227.145753.1111293673513137413.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Subject: Re: [PATCH net-next] ibm emac: delete module references; phy.c
 only supported as built-in
From: David Miller <davem@davemloft.net>
In-Reply-To: <1330372024-30974-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330372024-30974-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 27 Feb 2012 14:47:04 -0500

> The Makefile has it as "ibm_emac-y := mal.o core.o phy.o" so there is
> no way this can be built modular, so remove all references to module
> support.

That doesn't mean it's only buildable statically.

"ibm_emacs-y :=" is merely a way to tell make what objects go into ibm_emac.{o,ko}

IBM_EMAC is tristate
