Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 35AC7B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 00:55:09 +1000 (EST)
Date: Tue, 9 Aug 2011 09:55:07 -0500
From: Robin Holt <holt@sgi.com>
To: U Bhaskar-B22300 <B22300@freescale.com>
Subject: Re: [PATCH 4/4] [powerpc] Add flexcan device support for p1010rdb.
Message-ID: <20110809145507.GY4926@sgi.com>
References: <1312892907-20419-1-git-send-email-holt@sgi.com>
	<1312892907-20419-5-git-send-email-holt@sgi.com>
	<9C64B7751C3BCA41B64A68E23005A7BE1C4A88@039-SN1MPN1-002.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9C64B7751C3BCA41B64A68E23005A7BE1C4A88@039-SN1MPN1-002.039d.mgd.msft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"socketcan-core@lists.berlios.de" <socketcan-core@lists.berlios.de>,
	Robin Holt <holt@sgi.com>, PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 02:45:58PM +0000, U Bhaskar-B22300 wrote:
> Hi Robin,
> 	Where are you doing the irq handling ie request_irq() for the powerpc based P1010.
> 	Or the existing code of ARM based FlexCAN will work for P1010 ??

It appears that the of_device stuff got moved under the struct device
and that allows the request_irq() to just magically work.

Robin
