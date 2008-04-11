Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 29284DECD5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 03:21:07 +1000 (EST)
Date: Fri, 11 Apr 2008 21:21:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
Message-ID: <20080411172106.GA17786@polina.dev.rtsoft.ru>
References: <20080311171045.GB4684@localhost.localdomain>
	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
	<47FF9665.7020403@freescale.com>
	<20080411170657.GA15270@polina.dev.rtsoft.ru>
	<20080411171109.GA16119@polina.dev.rtsoft.ru>
	<47FF9BFE.5000201@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47FF9BFE.5000201@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 12:12:30PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > Or maybe I'm thinking here in terms of "fsl,ucc"... and cell-index is
> > indeed should be -1... don't know. Please decide. ;-)
> 
> Well, that's what I was thinking.  cell-index is zero-based, so UCC1 should have
> cell-index = <0>.
> 
> Of course, this means all the code needs to change, since I think device-id is
> one-based.

Yup. You raised a really good question, because we're _introducing_
cell-index for UCC nodes, and if we'll choice wrong numbering scheme
now, then there will be no way back w/o breaking backward compatibility.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
