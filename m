Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 05EA467AC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 11:55:55 +1000 (EST)
Date: Thu, 21 Apr 2005 18:55:52 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Marco Schramel <Schramel.Linux@go.bartec.de>,
	PPC_LINUX <linuxppc-embedded@ozlabs.org>
Message-ID: <20050422015552.GD20046@gate.ebshome.net>
References: <20050421103234.ED367C1510@atlas.denx.de>
	<200504211502.48761.Schramel.Linux@go.bartec.de>
	<20050422013134.GB27755@wohnheim.fh-wedel.de>
	<20050422015337.GC20046@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050422015337.GC20046@gate.ebshome.net>
Subject: Re: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2005 at 06:53:37PM -0700, Eugene Surovegin wrote:
> On Fri, Apr 22, 2005 at 03:31:34AM +0200, J?rn Engel wrote:
> 
> [snip]
> 
> > 1. Erase the flash partition.  Either
> >    o eraseall /dev/mtdX or
> >    o cat file_filled_with_0xff > /dev/mtdblockX
> 
> Huh? I fail to see how options you listed are equivalent. By 
> "cat"ing file filled with 0xff you cannot erase flash, period.
> 
> Only eraseall (or erase, if partition occupies 1 erase block) flash 
> can be erased.

Oops, sorry, I failed to notice /dev/mtdblockX. Stupid me. Ignore this 
noise.

-- 
Eugene
