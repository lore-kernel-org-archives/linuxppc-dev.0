Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 706B6DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 10:35:20 +1100 (EST)
In-Reply-To: <20090324.162913.226453070.davem@davemloft.net>
References: <OF603BDF0B.B740DD77-ONC1257583.007CAD9B-C1257583.007CFD35@transmode.se>	<20090324.154902.206324978.davem@davemloft.net>
	<OF4B79F4DE.4DC6DEA7-ONC1257583.007ECBEA-C1257583.007F2805@transmode.se>
	<20090324.162913.226453070.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
MIME-Version: 1.0
Subject: Re: [PATCH] ucc_geth: Convert to net_device_ops
Message-ID: <OF3500930F.BEAC23ED-ONC1257583.008165CC-C1257583.0081924C@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 25 Mar 2009 00:35:16 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> wrote on 25/03/2009 00:29:13:
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Wed, 25 Mar 2009 00:08:53 +0100
> 
> > David Miller <davem@davemloft.net> wrote on 24/03/2009 23:49:02:
> > > 
> > > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > > Date: Tue, 24 Mar 2009 23:45:13 +0100
> > > 
> > > > I don't follow. Are these mandatory now? They were not in the old
> > > > impl. either.
> > > 
> > > See ether_setup() which is called indirectly via alloc_etherdev().
> > > 
> > > Yawn...
> > 
> > Same here, getting tiered. Should have seen that. Here goes,
> > attatched as well as explained earlier.
> 
> I'll apply this, thanks.

Thanks.
> 
> Please provide a proper "Signed-off-by:" line with future
> patch submissions, thanks.

Yep, getting tiered ...
Hopefully I will have something more coming your way the next few days.
