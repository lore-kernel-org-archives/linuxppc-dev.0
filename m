Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC85BDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:37:37 +1100 (EST)
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <cover.1223482372.git.bgat@billgatliff.com>
References: <cover.1223482372.git.bgat@billgatliff.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 14:20:19 +1100
Message-Id: <1223608819.8157.127.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
> This series proposes a "generic PWM" driver API.
> 
> This proposed API is motivated by the author's need to support
> pluggable devices; a secondary objective is to consolidate the
> existing PWM implementations behind an agreeable, consistent,
> redundancy-reducing interface.

 .../...

You should send your patches to the main linux kernel list !

Cheers,
Ben
