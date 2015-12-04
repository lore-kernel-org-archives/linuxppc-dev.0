Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 502091A0B74
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 07:08:21 +1100 (AEDT)
Date: Fri, 04 Dec 2015 15:08:17 -0500 (EST)
Message-Id: <20151204.150817.532736454345962933.davem@davemloft.net>
To: joe@perches.com
Cc: madalin.bucur@freescale.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, igal.liberman@freescale.com, ppc@mindchasers.com,
 pebolle@tiscali.nl, joakim.tjernlund@transmode.se,
 gregkh@linuxfoundation.org
Subject: Re: [net-next v5 2/8] dpaa_eth: add support for DPAA Ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449259235.8611.19.camel@perches.com>
References: <1449150589-26253-3-git-send-email-madalin.bucur@freescale.com>
 <20151204.145549.859527220803940077.davem@davemloft.net>
 <1449259235.8611.19.camel@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Fri, 04 Dec 2015 12:00:35 -0800

> On Fri, 2015-12-04 at 14:55 -0500, David Miller wrote:
>> From: Madalin Bucur <madalin.bucur@freescale.com>
>> Date: Thu, 3 Dec 2015 15:49:43 +0200
>> =

>> > @@ -0,0 +1,22 @@
>> > +menuconfig FSL_DPAA_ETH
>> > +=A0=A0=A0=A0=A0tristate "DPAA Ethernet"
>> > +=A0=A0=A0=A0=A0depends on FSL_SOC && FSL_BMAN && FSL_QMAN && FSL_=
FMAN
>> > +=A0=A0=A0=A0=A0select PHYLIB
>> > +=A0=A0=A0=A0=A0select FSL_FMAN_MAC
>> =

>> I do not see the FSL_FMAN_MAC Kconfig symbol defined anywhere in the=

>> tree.
> =

> I believe this patch series is dependent on two
> other patch series mentioned in the cover letter.

Then this shouldn't have been submitted.

The dependent series has been through a lot of changes and still needs
lots of work, and is very far from being applied.

Posting patches depending upon it is therefore wholly inapproprate.
That time and effort should be spent putting the dependent series
into proper shape.

Since I see what is happening here, I am going to simply ignore all
future submissions of dpaa_eth, until the dependencies are worked
out properly so don't bother posting this stuff again until that
happens.

Thanks.
