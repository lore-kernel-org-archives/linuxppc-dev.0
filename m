Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 42E65B7B92
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 19:06:46 +1000 (EST)
Message-ID: <4A83D792.9020201@embedded-sol.com>
Date: Thu, 13 Aug 2009 12:06:26 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, leoli@freescale.com, zw@zh-kernel.org
Subject: Re: Using dmatest driver with FSL DMA engine
References: <4A83C6DC.8090405@embedded-sol.com>
In-Reply-To: <4A83C6DC.8090405@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
> Hi,
>
> I'm trying to use dmatest driver on MPC8536DS running linux 2.6.31-rc5.
> The loading of driver fails, as it is unable to allocate DMA channel.
> Is this driver supposed to work with FSL DMA engine ?
>

I should have disabled "TCP receive copy offload" DMA client.
dmatest works now as expected. Sorry for the noise.

Felix.
