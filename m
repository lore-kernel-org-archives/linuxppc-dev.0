Return-Path: <davem@davemloft.net>
Received: from cheetah.davemloft.net (dsl027-180-174.sfo1.dsl.speakeasy.net
	[216.27.180.174]) by ozlabs.org (Postfix) with ESMTP id 34CF067A8A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 14:53:31 +1100 (EST)
Date: Tue, 8 Mar 2005 19:42:29 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20050308194229.41c23707.davem@davemloft.net>
In-Reply-To: <1110334456.32556.21.camel@gaston>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>
	<1110334456.32556.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: PHY Abstraction Layer II
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 09 Mar 2005 13:14:16 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I'll have a closer look when I find some time, see if it makes sense to
> adapt sungem or not.

Especially because of the Broadcom PHYs I bet it doesn't.

Too many chips have to reset the MAC, or do other fancy stuff
when programming the PHY to make this genphy thing very useful.
