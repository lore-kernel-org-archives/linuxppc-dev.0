Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFC9BDDF89
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 02:29:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NGTL20021031
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 12:29:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NGQD21095168
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:29:20 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NGH8In004538
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:17:09 -0600
Date: Tue, 23 Oct 2007 11:17:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support to
	NEW EMAC.
Message-ID: <20071023111706.2af5735d@weaponx.rchland.ibm.com>
In-Reply-To: <38505C5B-4252-4AA7-B4F5-6B5267A6DBAA@kernel.crashing.org>
References: <20071015175717.GA4602@ru.mvista.com> <4713B10B.5000607@garzik.org>
	<20071023102035.6d35d3fe@weaponx.rchland.ibm.com>
	<38505C5B-4252-4AA7-B4F5-6B5267A6DBAA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 23 Oct 2007 11:13:48 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Oct 23, 2007, at 10:20 AM, Josh Boyer wrote:
> 
> > On Mon, 15 Oct 2007 14:27:23 -0400
> > Jeff Garzik <jeff@garzik.org> wrote:
> >
> >> Valentine Barshak wrote:
> >>> This patch adds BCM5248 and Marvell 88E1111 PHY support to NEW  
> >>> EMAC driver.
> >>> These PHY chips are used on PowerPC 440EPx boards.
> >>> The PHY code is based on the previous work by Stefan Roese  
> >>> <sr@denx.de>
> >>>
> >>> Signed-off-by: Stefan Roese <sr@denx.de>
> >>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> >>> ---
> 
> You guys should really look at moving emac over to the phylib so we  
> don't have to duplicate drivers for the same phys all over the place :)

Yes, we should.  It's on the list.  Just not for 2.6.24 since it's way
too late.

josh
