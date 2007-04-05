Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 43958DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 18:33:43 +1000 (EST)
Date: Thu, 5 Apr 2007 10:33:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: SPI devices and OF
Message-ID: <20070405083337.GB9910@localhost.localdomain>
References: <20070404110916.GA9910@localhost.localdomain>
	<acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
	<4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 11:34:11AM -0500, Kumar Gala wrote:
> 
> On Apr 4, 2007, at 6:51 AM, Vitaly Wool wrote:
> 
> 
> I don't think this is a good idea for SPI devices.  The effort vs  
> reward isn't worth it.  The simple fact that the 'chip select'  
> mechanism ends up being board specific is too much of a pain to  
> figure out how to deal with in the device tree.  I think its ok if we  
> put information about the controller in the tree, but trying to do  
> the devices as well at this point doesn't seem like its much of a win.

It would be much easier to provide some board specific functions which
registers the spi devices instead of doing it in the device tree.
But there is one problem with that: If there is more than one spi
controller in the tree, how do you differentiate them?


Sascha
