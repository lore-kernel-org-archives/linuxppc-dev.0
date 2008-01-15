Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F22E4DDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 05:22:20 +1100 (EST)
Date: Tue, 15 Jan 2008 12:32:40 -0600
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] [POWERPC] 4xx: Add 405EXr to cputable
Message-ID: <20080115183240.GC25749@lixom.net>
References: <1200380955-10217-1-git-send-email-sr@denx.de>
	<20080115181924.GA3848@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080115181924.GA3848@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 12:19:24PM -0600, Scott Wood wrote:
> On Tue, Jan 15, 2008 at 08:09:15AM +0100, Stefan Roese wrote:
> > This patch adds the 405EXr to the powerpc cuptable. Basically the 405EXr
> > is a 405EX with only one EMAC and only one PCIe interface.
> 
> Sounds like they have the same core... why do they need separate cputable
> entries?

AMCC has always indicated SoC products by new PVRs. This isn't news,
even though it isn't exactly a clean solution. :)


-Olof
