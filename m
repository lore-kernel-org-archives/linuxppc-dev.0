Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 728182C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2013 04:05:40 +1100 (EST)
Date: Tue, 12 Feb 2013 12:05:36 -0500 (EST)
Message-Id: <20130212.120536.2017028310090249045.davem@davemloft.net>
To: R65777@freescale.com
Subject: Re: [PATCH v2] net: fec_mpc52xx: Read MAC address from device-tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D065A0271@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1360660088-27464-1-git-send-email-sr@denx.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D065A0271@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, sr@denx.de, agust@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Tue, 12 Feb 2013 10:56:05 +0000

> Why we read from MAC registers if Linux should not rely on bootloader?

Because it used to and if you just remove that code then you break
existing setups, and I explicitly told him to code things this way.
