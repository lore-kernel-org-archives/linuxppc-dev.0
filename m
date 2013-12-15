Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 7B8912C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 14:34:58 +1100 (EST)
Date: Sat, 14 Dec 2013 22:34:53 -0500 (EST)
Message-Id: <20131214.223453.1858856767733226007.davem@davemloft.net>
To: lists@nerdbynature.de
Subject: Re: 3.13-rc1: eth0 hw csum failure on powerpc (bisected)
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.11.1312141622230.25690@trent.utfs.org>
References: <alpine.DEB.2.11.1311301314220.31521__48727.6146108799$1385846242$gmane$org@trent.utfs.org>
 <87vbz9pmud.fsf@igel.home>
 <alpine.DEB.2.11.1312141622230.25690@trent.utfs.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, agraf@suse.de, schwab@linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christian Kujau <lists@nerdbynature.de>
Date: Sat, 14 Dec 2013 16:40:39 -0800 (PST)

> And sure enough, today's 3.13-rc3 with only that commit reverted boots 
> just fine on this PowerBook G4 system.

It's reverted in my 'net' tree, that tree simple hasn't been pushed to
Linus just yet, please be patient.
