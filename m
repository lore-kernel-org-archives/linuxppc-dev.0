Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C6B2DDF78
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:05:32 +1000 (EST)
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4713B726.6080404@garzik.org>
References: <20071015175717.GA4602@ru.mvista.com> <4713B10B.5000607@garzik.org>
	<20071015134813.6aacdcca@weaponx.rchland.ibm.com>
	<4713B726.6080404@garzik.org>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 07:02:51 +1000
Message-Id: <1192482171.11795.35.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-15 at 14:53 -0400, Jeff Garzik wrote:
> Roland Dreier (2):
>        ibm_new_emac: Nuke SET_MODULE_OWNER() use
>        ibm_emac: Convert to use napi_struct independent of struct
> net_device
> 

Wow, I'd have loved to be CCed at least on the last one since I was
about to do just that ... Heh.

Ben.
