Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B62BADE0BF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 03:27:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9FHRjdV018799
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 13:27:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9FHQmfI484504
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 11:27:44 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9FHQH1X016941
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 11:26:18 -0600
Date: Mon, 15 Oct 2007 12:26:16 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: Add NEW EMAC driver support to 440EPx Sequoia
	board.
Message-ID: <20071015122616.08250b54@weaponx.rchland.ibm.com>
In-Reply-To: <20071012130305.GA14682@ru.mvista.com>
References: <20071012130305.GA14682@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 12 Oct 2007 17:03:05 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> This patch enables NEW EMAC support for PowerPC 440EPx Sequoia board
> and adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
> These PHY chips are used on PowerPC440EPx boards.
> The PHY code is based on the previous work by Stefan Roese <sr@denx.de>

Could you send the phy part to Jeff Garzik and the netdev list by
itself?  That way it will get picked up and we'll update the Kconfig
with a later patch.

josh
