Return-Path: <SSparks@aclaratech.com>
Received: from SG2EHSOBE001.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 98B62DDFA9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 00:26:08 +1000 (EST)
Received: from mail82-sin (localhost.localdomain [127.0.0.1])	by
	mail82-sin-R.bigfish.com (Postfix) with ESMTP id 469D3BE0213	for
	<linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:26:04 +0000 (UTC)
Received: from acl-exch.aclaratech.com (unknown [68.89.149.23])	by
	mail82-sin.bigfish.com (Postfix) with ESMTP id C52ADF9806A	for
	<linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:26:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Compact Flash on 8349mITX
Date: Thu, 31 Jul 2008 09:24:35 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A8355608634218F@mail.twacs.com>
In-Reply-To: <6011A7C9CD0EE74792C3ED2A835560861FA9C0@mail.twacs.com>
References: <6011A7C9CD0EE74792C3ED2A835560861FA9C0@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From: Sparks, Sam=20
>Sent: Thursday, July 31, 2008 8:15 AM
>Does irq polling need to be used for compact flash to work=20
>with this version of the kernel on this board?

When I remove the interrupt definition from the DTS (to cause
irqpolling), the ata driver gets stuck in a loop displaying the
following. Does anyone have any insight?
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1.00: revalidation failed (errno=3D-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus
error)
