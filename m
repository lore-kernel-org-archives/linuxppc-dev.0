Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2977A51B1B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:40:11 +1000 (EST)
Date: Wed, 06 May 2009 13:40:03 -0700 (PDT)
Message-Id: <20090506.134003.261424694.davem@davemloft.net>
To: wd@denx.de
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1241640919-4650-3-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kosmo@semihalf.com, jrigby@freescale.com, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Would you be offended if I tell you that this is a horrible patch
submission?

Your introductory email indicates 16 patches, yet the series indicates
there were 12, and that intro email is only posted to the linuxppc-dev
list for people to read.  Nobody on netdev nor other interested
parties that get CC:'d along the line are able to read what this patch
series is about.

Since only some patches are CC:'d to netdev I have no idea if I should
apply these or they are dependent on some other patches in the series
that you didn't send here to netdev.

What a mess... how can any maintainer figure out what patch is what,
and what tree you expect these patches to even get applied to?

I'm definitely sending all of the copies I have received to /dev/null,
you need to submit this work properly.
