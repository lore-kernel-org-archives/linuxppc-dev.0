Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 9898E2BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2005 01:57:48 +1100 (EST)
Date: Thu, 13 Jan 2005 07:57:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Message-ID: <20050113145747.GY3391@smtp.west.cox.net>
References: <9FCDBA58F226D911B202000BDBAD46730813D2@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730813D2@zch01exm40.ap.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 8272ADS FCC clock setting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 13, 2005 at 05:49:25PM +0800, Li Yang-r58472 wrote:

> The patches fix Clock pin Configuration of MPC8272ADS board FCC support, and clear up comment on it.

This shouldn't be required in linuxppc-2.4, as I pushed your patch to
cleanup the pin selection earlier, and I'll see about getting it into
2.4.30 (too late for 2.4.29).  For 2.6, I've pushed these changes (along
with some others for PQ2FADS) into linuxppc-2.5, as the fcc_enet driver
in stock 2.6 needs massive updates (I'm hoping it can be obsoleted by a
new one from Andy Flemming).

-- 
Tom Rini
http://gate.crashing.org/~trini/
