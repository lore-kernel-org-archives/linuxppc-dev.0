Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 255CEDDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:49:15 +1100 (EST)
Date: Tue, 24 Mar 2009 15:49:02 -0700 (PDT)
Message-Id: <20090324.154902.206324978.davem@davemloft.net>
To: Joakim.Tjernlund@transmode.se
Subject: Re: [PATCH] ucc_geth: Convert to net_device_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF603BDF0B.B740DD77-ONC1257583.007CAD9B-C1257583.007CFD35@transmode.se>
References: <OFA0B803BB.DEC93B9A-ONC1257583.0039CF3E-C1257583.003A55BA@transmode.se>
	<20090324.142209.234280606.davem@davemloft.net>
	<OF603BDF0B.B740DD77-ONC1257583.007CAD9B-C1257583.007CFD35@transmode.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 24 Mar 2009 23:45:13 +0100

> I don't follow. Are these mandatory now? They were not in the old
> impl. either.

See ether_setup() which is called indirectly via alloc_etherdev().

Yawn...
