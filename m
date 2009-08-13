Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BA3FCB7BA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 19:02:26 +1000 (EST)
Message-ID: <4A83C6DC.8090405@embedded-sol.com>
Date: Thu, 13 Aug 2009 10:55:08 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, leoli@freescale.com, zw@zh-kernel.org
Subject: Using dmatest driver with FSL DMA engine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to use dmatest driver on MPC8536DS running linux 2.6.31-rc5.
The loading of driver fails, as it is unable to allocate DMA channel.
Is this driver supposed to work with FSL DMA engine ?

Thanks.

Felix.
