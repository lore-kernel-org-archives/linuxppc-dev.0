Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DBFFDDFEE
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 02:15:12 +1000 (EST)
In-Reply-To: <20071023102035.6d35d3fe@weaponx.rchland.ibm.com>
References: <20071015175717.GA4602@ru.mvista.com> <4713B10B.5000607@garzik.org>
	<20071023102035.6d35d3fe@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38505C5B-4252-4AA7-B4F5-6B5267A6DBAA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support to
	NEW EMAC.
Date: Tue, 23 Oct 2007 11:13:48 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 23, 2007, at 10:20 AM, Josh Boyer wrote:

> On Mon, 15 Oct 2007 14:27:23 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
>
>> Valentine Barshak wrote:
>>> This patch adds BCM5248 and Marvell 88E1111 PHY support to NEW  
>>> EMAC driver.
>>> These PHY chips are used on PowerPC 440EPx boards.
>>> The PHY code is based on the previous work by Stefan Roese  
>>> <sr@denx.de>
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>>> ---

You guys should really look at moving emac over to the phylib so we  
don't have to duplicate drivers for the same phys all over the place :)

- k
