Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 1D81A2BF12
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2005 01:30:22 +1100 (EST)
Date: Thu, 13 Jan 2005 07:30:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Message-ID: <20050113143020.GX3391@smtp.west.cox.net>
References: <9FCDBA58F226D911B202000BDBAD46730813D3@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730813D3@zch01exm40.ap.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] cpm2_io/fcc_enet: make clock setting more
	straightforward
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 13, 2005 at 06:07:49PM +0800, Li Yang-r58472 wrote:

> This patch refined the clock setting part of FCC Ethernet driver, making it easier for further porting.  It also fixed MPC8272ADS setting.  If apply this patch, the previous patch is not needed.

This looks like what I thought I pushed to linuxppc-2.4 already.  Once
linux-2.4.29 comes out I'll work with Kumar and Marcelo to see what we
can get merged back into the main linux-2.4 tree again.

-- 
Tom Rini
http://gate.crashing.org/~trini/
