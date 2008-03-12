Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ABDADDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 23:34:45 +1100 (EST)
Date: Wed, 12 Mar 2008 13:34:37 +0100
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Using the loop feature of the DMA controller on MPC8544 DS
Message-ID: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have here a MPC8544 DS board and I tried to utilise the dma
controller. For the transfers I need set the [S|D]AHE bit in the Mode
Register. This seems to be implemented but is currently unused in the
driver. I haven't found a way how to set this bit except globally for
the whole channel.
Is it possible to solve this nicely except dedicating one channel for
such an operation?

thanks,
 Sebastian
