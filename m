Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AD3A5B6EEB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 08:11:37 +1100 (EST)
Date: Wed, 24 Mar 2010 14:11:58 -0700 (PDT)
Message-Id: <20100324.141158.43422101.davem@davemloft.net>
To: elendil@planet.nl
Subject: Re: [PATCH 00/09] net: remove trailing spaces in messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <201003241840.18701.elendil@planet.nl>
References: <201003241840.18701.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jon.maloy@ericsson.com, samuel@sortiz.org,
	e1000-devel@lists.sourceforge.net, per.liden@ericsson.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, allan.stephens@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frans Pop <elendil@planet.nl>
Date: Wed, 24 Mar 2010 18:40:15 +0100

> This is the second patchset to remove trailing spaces in kernel messages. 
> Patches in this set cover networking code, excepting wireless which will be 
> submitted in a separate set.
> 
> Patches have been rebased against current net-next.
> 
> Benefits are:
> - general cleanup and consistency
> - minor reduction in kernel size and user's log file size
> - reduced annoyance for people writing logcheck rules
> 
> I have run the patches through checkpatch and included some fixes, but in 
> most cases the files are so horrible in general that fixing the warnings 
> purely for these changes doesn't make sense.

All applied, but I have to make some fixups.

For example, GIT warns about trailing whitespace on any lines that you
touched so I had to fix those up before putting them into the tree.

Thanks.
