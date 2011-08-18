Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6507AB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 13:39:08 +1000 (EST)
Date: Wed, 17 Aug 2011 20:36:52 -0700 (PDT)
Message-Id: <20110817.203652.1534418728105616430.davem@davemloft.net>
To: holt@sgi.com
Subject: Re: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan
	(freescale p1010)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1313551944-28603-1-git-send-email-holt@sgi.com>
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, B22300@freescale.com,
	socketcan-core@lists.berlios.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Robin Holt <holt@sgi.com>
Date: Tue, 16 Aug 2011 22:32:18 -0500

> The following set of patches have been reviewed by the above parties and
> all comments have been integrated.  Although the patches stray from the
> drivers/net/can directory, the diversions are related to changes for
> the flexcan driver.
> 
> The patch set is based upon your net-next-2.6 tree's commit 6c37e46.
> 
> Could you please queue these up for the next appropriate push to Linus'
> tree?

Applied to net-next, thanks!
