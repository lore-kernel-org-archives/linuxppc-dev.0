Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D961DDF1C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 09:23:43 +1100 (EST)
Subject: Re: pmac_zilog debugging ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <4914B549.9010805@hypersurf.com>
References: <4914B549.9010805@hypersurf.com>
Content-Type: text/plain
Date: Sat, 08 Nov 2008 09:23:23 +1100
Message-Id: <1226096603.13603.74.camel@pasglop>
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

On Fri, 2008-11-07 at 13:38 -0800, Kevin Diggs wrote:
> to connect an 8600 to a laptop via ppp the link will lock up in short
> order from "payloaded" pings. Any advice on how to figure out where it
> is locking up? This command works fine to connect two x86 laptops. At
> 1200 it does take a while for an xterm to show up, though.

Flow control might be busted. You may need to revert the polarity of the
CTS line sampling. Let me know what you find out.

Cheers,
Ben.
