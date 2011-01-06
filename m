Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C8C22B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Jan 2011 07:52:14 +1100 (EST)
Date: Thu, 6 Jan 2011 12:52:10 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: deebul nair <deebuls@gmail.com>
Subject: Re: DMA implementation on MPC8572
Message-ID: <20110106205210.GJ17022@ovro.caltech.edu>
References: <AANLkTik1br89HU+sUOfHYB74uWqOBJSCNpbvf21xsh_r@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTik1br89HU+sUOfHYB74uWqOBJSCNpbvf21xsh_r@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 06, 2011 at 07:54:16PM +0530, deebul nair wrote:
> Hi all
> 
> I am using the MPC8572 processor.
> I wanted to use the DMA functionality in the powerpc board for talking to a
> FPGA device connected on the loacl bus.
> 
> I have compiled the fsldma.c code and inserted it.
> On insertion the driver probes all the dma channels
> Can anyone tell me how to test the driver and also how to use the driver?
> 

For memcpy tests, the dmatest module provides a good example. See
drivers/dma/dmatest.c for the source.

For more advanced usage, search the archives for:
[PATCH RFCv3 0/2] CARMA Board Support

Those drivers use some of the advanced features of the DMAEngine API to
transfer data from an FPGA into RAM.

Ira
