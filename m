Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 58265B7B7A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 21:42:55 +1100 (EST)
Date: Wed, 07 Oct 2009 03:43:09 -0700 (PDT)
Message-Id: <20091007.034309.111268582.davem@davemloft.net>
To: olof@lixom.net
Subject: Re: [PATCH] pasemi_mac: ethtool get settings fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091006161054.GB29195@lixom.net>
References: <4AC9ED9B.5040400@ru.mvista.com>
	<20091005132756.GA11704@ru.mvista.com>
	<20091006161054.GB29195@lixom.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Olof Johansson <olof@lixom.net>
Date: Tue, 6 Oct 2009 11:10:54 -0500

> Weird, I see my address in the to: line but I never got a copy in my inbox.
> 
> On Mon, Oct 05, 2009 at 05:27:56PM +0400, Valentine Barshak wrote:
>> Not all pasemi mac interfaces can have a phy attached.
>> For example, XAUI has no phy and phydev is NULL for it.
>> In this case ethtool get settings causes kernel crash.
>> Fix it by returning -EOPNOTSUPP if there's no PHY attached.
>> 
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Applied to net-2.6, thanks!
