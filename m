Return-Path: <dgibson@ozlabs.org>
Date: Thu, 13 Sep 2007 15:29:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: sivaji <rameshmrm@gmail.com>
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
Message-ID: <20070913052932.GF14905@localhost.localdomain>
References: <12648489.post@talk.nabble.com>
	<46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net>
	<12648696.post@talk.nabble.com>
	<5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
	<12648913.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12648913.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 10:24:22PM -0700, sivaji wrote:
> 
> 
> Hi,
>         I am not willing to upgrade the uboot. Becuase it takes some time to
> port the new uboot for my custom boad.
> whether the current problem is related to uboot ? One more point, previously
> i tried 2.6.21 with the same uboot(1.1.6) we got linux prompt but we face
> some issue in the pci express in that version. so we plan to upgrade the
> kernel version.

I thought u-boot < 1.3 didn't understand the flat tree at all.  In
which case you'll need a cuboot zImage.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
