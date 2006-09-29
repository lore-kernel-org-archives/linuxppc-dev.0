Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7336167BCB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 06:15:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8TLZjeK013265
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 15:35:45 -0600 (MDT)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8TKFj4o011806
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 15:15:45 -0500 (CDT)
Message-ID: <451D7EF1.70704@freescale.com>
Date: Fri, 29 Sep 2006 15:15:45 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: no map ! Using irq line 0 from PCI config
References: <451C365B.8090300@freescale.com>
In-Reply-To: <451C365B.8090300@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> I'm having a problem with a SATA PCI device on an 8349E board.  The SATA driver is timing out when trying to query the drive.  I believe this is happening because interrupts aren't being routed correctly.

Never mind ... my interrupt-map node was completely wrong.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
