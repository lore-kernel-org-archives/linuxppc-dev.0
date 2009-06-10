Return-Path: <jk@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 526B9B70BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 22:44:25 +1000 (EST)
From: Jeremy Kerr <jk@ozlabs.org>
To: patchwork@ozlabs.org
Subject: Re: [PATCH 3/5] can: af_can.c use rcu_barrier() on module unload.
Date: Wed, 10 Jun 2009 22:41:47 +1000
References: <4A2D112A.4000308@hartkopp.net> <4A2F6D32.8030400@hartkopp.net>
	<20090610.015245.141342130.davem@davemloft.net>
In-Reply-To: <20090610.015245.141342130.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906102241.47823.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, oliver@hartkopp.net,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David,

> We really can't expect patchwork to look for every conceivable
> malignment of the various reviewer tags.

No, but we could probably be more tolerant about capitalisation. Any 
objections about ignoring case completely? I have a patch ready to 
push...

Cheers,


Jeremy
