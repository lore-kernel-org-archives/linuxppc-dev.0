Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE223DDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 07:15:35 +1100 (EST)
Subject: Re: [PATCH 2/2] [PPC 44x] enable L2-cache for ALPR, Katmai,
	Ocotea, and Taishan
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20071128194727.GA22325@gate.ebshome.net>
References: <1416528026.20071107014041@emcraft.com>
	<1196120506.7157.18.camel@pasglop>
	<20071128194727.GA22325@gate.ebshome.net>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 07:15:13 +1100
Message-Id: <1196280913.13230.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-28 at 11:47 -0800, Eugene Surovegin wrote:
> On Tue, Nov 27, 2007 at 10:41:46AM +1100, Benjamin Herrenschmidt wrote:
> > BTW... Do you know why we can't just enable HW snoop ? The 440SPe
> > documentation seems to indicate that this is supported by the L2 cache
> > via snooping on the PLB.
> 
> Unless something has been changed significantly in the 44x port, but 
> L2 cache code I wrote for 440GX did exactly this - we never needed any 
> manual L2 cache management at all.

Ah good. So we should port that code over instead.

Thanks !
Ben.
