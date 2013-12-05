Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9F9FD2C0087
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Dec 2013 15:50:01 +1100 (EST)
Message-ID: <1386218991.21910.18.camel@pasglop>
Subject: Re: [PATCH 3/8] IBM Akebono: Add support for a new PHY interface to
 the IBM emac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Thu, 05 Dec 2013 15:49:51 +1100
In-Reply-To: <1385086116-10972-3-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <1385086116-10972-3-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-22 at 13:08 +1100, Alistair Popple wrote:
> The IBM PPC476GTR SoC that is used on the Akebono board uses a
> different ethernet PHY interface that has wake on lan (WOL) support
> with the IBM emac. This patch adds support to the IBM emac driver for
> this new PHY interface.
> 
> At this stage the wake on lan functionality has not been implemented.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
