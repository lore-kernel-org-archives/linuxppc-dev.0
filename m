Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 28D712C0087
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2013 08:16:36 +1100 (EST)
Date: Tue, 12 Feb 2013 16:16:34 -0500 (EST)
Message-Id: <20130212.161634.379840915476776959.davem@davemloft.net>
To: sr@denx.de
Subject: Re: [PATCH v3] net: fec_mpc52xx: Read MAC address from device-tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <1360674338-12776-1-git-send-email-sr@denx.de>
References: <1360674338-12776-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, agust@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>
Date: Tue, 12 Feb 2013 14:05:38 +0100

> v3:
> - Use of_get_mac_address() instead of of_get_property()

Just to clarify, I applied this version (v3), not v2 (which I
just replied to with "applied").
