Return-Path: <lhthanh@kobekara.com>
Received: from phobos.lunarpages.com (phobos.lunarpages.com [67.210.120.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40F1ADDEFD
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 23:58:25 +1000 (EST)
Received: from [202.78.230.98] (helo=[192.168.3.61])
	by phobos.lunarpages.com with esmtpa (Exim 4.69)
	(envelope-from <lhthanh@kobekara.com>) id 1Lvsnd-0004py-Bx
	for linuxppc-dev@ozlabs.org; Mon, 20 Apr 2009 05:40:37 -0700
Message-ID: <49EC6CB5.2020300@kobekara.com>
Date: Mon, 20 Apr 2009 19:38:13 +0700
From: lhthanh <lhthanh@kobekara.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: MPC8349E's DMA controller like ISA controller but with more feature?
Content-Type: text/html; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="+1">Hi EveryOne!<br>
<br>
This is first time I send a letter to everyone. If I make mistake,
please free to correct me. :)<br>
<br>
I'm trying to write the first driver which is concerned with DMA. I'm
reading dmatest.c and have some confused problem. Oh! No! I have many
problem..:D<br>
MPC8349's DMA controller like ISA controller but with more features? I
want to mean that MPC8349E's DMA controller will send -MEMR, -MEMW,
-IOR, -IOW ?.<br>
So in DMA APIs such as dma_addr_t dma_map_single(struct device *dev,
void *cpu_addr, size_t size, enum dma_data_direction direction)<br>
<br>
*dev will pointer to DMA controller or to peripheral device(FPGA, ISA
device)? From dmatest.c , *dev seem to pointer to a channel of DMA
controller. <br>
The channel is connected to a peripheral device. So calling the API,
DMA controller will be able to access memory from cpu_addr, and
peripheral device does too?<br>
<br>
Look struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(struct
dma_chan *chan,   dma_addr_t        dest,       dma_addr_t        src,<br>
                                                                                                                               
size_t len, unsigned long flags);<br>
I want to DMA from device to memory. So how to I can get address of
peripheral device ?<br>
<br>
Regards!</font>
</body>
</html>
