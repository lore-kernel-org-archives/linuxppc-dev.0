Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 42B15DDE9B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 19:59:52 +1000 (EST)
Date: Fri, 7 Sep 2007 11:59:50 +0200
To: Vinu <vvaghasia@gen10technology.com>
Subject: Re: How to use MMC-over-SPI on MPC8313E
Message-ID: <20070907095950.GA29317@powerlinux.fr>
References: <46E02F48.6090005@gen10technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46E02F48.6090005@gen10technology.com>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 11:48:08AM -0500, Vinu wrote:
> Hi all,
> 
> I am working on MPC8313ERDB  Eval board, and want to  use SD Memory card 
> to store Linux OS and file system.
> The SD card controller is connected directly with the SPI bus.
> 
> I simply don't know how to use MMC-over-SPI  technology to make SD card 
> usable.
> 
> It would be a great help if anybody have any documentation or driver etc.

I have recently written a MMC-over-SPI driver for a MPC875 card. It used
the block device directly, and is rather straightforward, but maybe not
so nice as it could be. I need to unbrand it, and can send it to you
later on. Please ping me this WE if you are interested.

Friendly,

Sven Luther
