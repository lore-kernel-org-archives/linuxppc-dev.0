Return-Path: <davem@davemloft.net>
Date: Wed, 15 Feb 2012 16:42:45 -0500 (EST)
Message-Id: <20120215.164245.2208394038607502286.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] of: Only compile OF_DYNAMIC on PowerPC pseries and iseries
From: David Miller <davem@davemloft.net>
In-Reply-To: <1329240330-3539-1-git-send-email-grant.likely@secretlab.ca>
References: <1329240330-3539-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 14 Feb 2012 10:25:30 -0700

> Only two architectures use the OF node reference counting and reclaim bits.
> There is no need to compile it for the rest of the PowerPC platforms or for
> any of the other architectures.  This patch makes iseries and pseries
> select CONFIG_OF_DYNAMIC, and makes it default to off for everything else.
> 
> It is still safe to turn on CONFIG_OF_DYNAMIC on all architectures, it just
> isn't necessary.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
