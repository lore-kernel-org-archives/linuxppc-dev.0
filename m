Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07138B7003
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2012 07:29:06 +1000 (EST)
Date: Fri, 11 May 2012 17:24:55 -0400 (EDT)
Message-Id: <20120511.172455.120522633866860614.davem@davemloft.net>
To: bjorn@mork.no
Subject: Re: [PATCH] net: of/phy: fix build error when phylib is built as a
 module
From: David Miller <davem@davemloft.net>
In-Reply-To: <1336751221-19127-1-git-send-email-bjorn@mork.no>
References: <20120510.224352.2149006669429730060.davem@davemloft.net>
 <1336751221-19127-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: sfr@canb.auug.org.au, david.daney@cavium.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
 rdunlap@xenotime.net, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bj=F8rn Mork <bjorn@mork.no>
Date: Fri, 11 May 2012 17:47:01 +0200

> Should be wrapped into commit 25106022 if it works, to ensure
> bisectability.

Wrapped into?

Commits made to my net-next tree are permanent and irreversible, so we
cannot go back and change a commit.  I never rebase my tree, too many
people use it directly and pull it into their tree, so I'd break their
world if I ever did that.
