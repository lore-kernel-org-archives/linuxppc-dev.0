Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D4BDDDE1A
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 19:22:22 +1000 (EST)
Date: Fri, 7 Sep 2007 13:22:12 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Vinu <vvaghasia@gen10technology.com>
Subject: Re: How to use MMC-over-SPI on MPC8313E
Message-ID: <20070907132212.36cd5cc6@localhost.localdomain>
In-Reply-To: <46E02F48.6090005@gen10technology.com>
References: <46E02F48.6090005@gen10technology.com>
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

On Thu, 06 Sep 2007 11:48:08 -0500
Vinu wrote:

> Hi all,
> 
> I am working on MPC8313ERDB  Eval board, and want to  use SD Memory
> card to store Linux OS and file system.
> The SD card controller is connected directly with the SPI bus.
> 
> I simply don't know how to use MMC-over-SPI  technology to make SD
> card usable.
> 
> It would be a great help if anybody have any documentation or driver
> etc.
> 

Please search list - there is 8323 support... We /mvista/ did such a thing not long ago. All the stuff releated to spi/mmc layer is already in mainline kernel, you'll just need to do board-specific patch for 8313 which should be similar to mentioned.
-- 
Sincerely, Vitaly
