Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9E4EE67B17
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 00:37:14 +1000 (EST)
Date: Mon, 19 Jun 2006 09:36:07 -0500
To: Till Wimmer <linuxppc-dev@tonarchiv.ch>
Subject: Re: L3 cache on Apple dual processor (7450 r 2.1) question
Message-ID: <20060619143607.GB4845@pb15.lixom.net>
References: <1150726624.4711.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1150726624.4711.16.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2006 at 04:17:04PM +0200, Till Wimmer wrote:

> Now my questions are:
> Is there anything else to do for getting the L3 cache working?
> How can i check if the L3 is enabled? E.g. is there a benchmark program
> which accounts for cache settings?

lmbench has testcases for memory latency testing.

http://www.bitmover.com/lmbench/


-Olof
