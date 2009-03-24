Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DD65DDDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 10:29:26 +1100 (EST)
Date: Tue, 24 Mar 2009 16:29:13 -0700 (PDT)
Message-Id: <20090324.162913.226453070.davem@davemloft.net>
To: Joakim.Tjernlund@transmode.se
Subject: Re: [PATCH] ucc_geth: Convert to net_device_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF4B79F4DE.4DC6DEA7-ONC1257583.007ECBEA-C1257583.007F2805@transmode.se>
References: <OF603BDF0B.B740DD77-ONC1257583.007CAD9B-C1257583.007CFD35@transmode.se>
	<20090324.154902.206324978.davem@davemloft.net>
	<OF4B79F4DE.4DC6DEA7-ONC1257583.007ECBEA-C1257583.007F2805@transmode.se>
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
Date: Wed, 25 Mar 2009 00:08:53 +0100

> David Miller <davem@davemloft.net> wrote on 24/03/2009 23:49:02:
> > 
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Tue, 24 Mar 2009 23:45:13 +0100
> > 
> > > I don't follow. Are these mandatory now? They were not in the old
> > > impl. either.
> > 
> > See ether_setup() which is called indirectly via alloc_etherdev().
> > 
> > Yawn...
> 
> Same here, getting tiered. Should have seen that. Here goes,
> attatched as well as explained earlier.

I'll apply this, thanks.

Please provide a proper "Signed-off-by:" line with future
patch submissions, thanks.
