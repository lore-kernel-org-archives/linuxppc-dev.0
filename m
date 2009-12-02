Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19AF91007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 11:01:18 +1100 (EST)
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4B15AA4F.5040309@kernel.org>
References: <20091201070834.6A840B7B63@ozlabs.org>
	<4B14CD22.4020806@kernel.org> <1259709552.2076.1053.camel@pasglop>
	<4B15A67C.2030102@kernel.org> <1259710543.2076.1054.camel@pasglop>
	<4B15AA4F.5040309@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Dec 2009 11:00:27 +1100
Message-ID: <1259712027.2076.1055.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Holger Macht <hmacht@suse.de>,
	linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-02 at 08:44 +0900, Tejun Heo wrote:
> > BTW. For a plug event, what should I do ? freeze is fine ? Or just
> > schedule eh ? Right now, when plugging I see an exception Emask 0x10
> > etc... message in the log when plugging which isn't totally nice :-)
> 
> freeze() and please don't fight the EH messages from low level driver.
> If it's too much, we need to update core layer but given the variety
> of phy related bugs, I think we need those messages.

Eh, ok :-) No biggie.

Cheers,
Ben.
