Return-Path: <lagrange@fr.oleane.com>
Received: from smtp03.msg.oleane.net (smtp03.msg.oleane.net [62.161.4.3])
	by ozlabs.org (Postfix) with ESMTP id 85106DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Nov 2008 02:57:09 +1100 (EST)
Received: from smtp03.msg.oleane.net (localhost [127.0.0.1])
	by smtp03.msg.oleane.net (MTA-AS) with ESMTP id mARFYDiT010179
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Nov 2008 16:34:13 +0100
Received: from GEGE6600V ([194.3.133.184]) (authenticated)
	by smtp03.msg.oleane.net (MTA) with ESMTP id mARFYD1P010095
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Nov 2008 16:34:13 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: TR: Async DMA completion
Date: Thu, 27 Nov 2008 16:33:56 +0100
Message-ID: <000101c950a5$9904e2f0$a501a8c0@GEGE6600V>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hello,

I would like to use async DMA driver to transfer data. I find no function to
wait for the end of the DMA transfer in blocking mode:
the only way to get the end of the transfer is the polling by the function
"dma_async_is_tx_complete".

To wait the end of the transfer, must I poll the transfer status by the
function "dma_async_is_tx_complete" or is there a function
that waits for a DMA channel interrupt ?

Thanks for any tips.
Laurent
