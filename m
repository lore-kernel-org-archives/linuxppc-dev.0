Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 47239DEBDF
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 13:56:09 +1100 (EST)
Date: Wed, 28 Nov 2007 20:59:20 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: Re: [PATCH] [0/12] pasemi_mac updates for 2.6.25 + DMA channel
	management library
Message-ID: <20071129025920.GN17215@lixom.net>
References: <20071129025410.GA17215@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129025410.GA17215@lixom.net>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 28, 2007 at 08:54:10PM -0600, Olof Johansson wrote:

> The patches are:
[...]

I got the order wrong above, the actual one is:

1/12 pasemi_mac: RX/TX ring management cleanup
2/12 pasemi_mac: Move register definitions to include/asm-powerpc
3/12 pasemi: DMA engine management library
4/12 pasemi_mac: Convert to new dma library
5/12 pasemi_mac: performance tweaks
6/12 pasemi_mac: Fix TX cleaning
7/12 pasemi_mac: Improve RX interrupt mitigation
8/12 pasemi_mac: Software-based LRO support
9/12 pasemi_mac: SKB unmap optimization
10/12 pasemi_mac: Remove SKB copy/recycle logic
11/12 pasemi_mac: Print warning when not attaching to a PHY
12/12 pasemi_mac: Don't enable RX/TX without a link (if possible)
