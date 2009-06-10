Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3916DB707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 02:45:15 +1000 (EST)
Date: Wed, 10 Jun 2009 09:45:12 -0700 (PDT)
Message-Id: <20090610.094512.90091251.davem@davemloft.net>
To: jk@ozlabs.org
Subject: Re: [PATCH 3/5] can: af_can.c use rcu_barrier() on module unload.
From: David Miller <davem@davemloft.net>
In-Reply-To: <200906102241.47823.jk@ozlabs.org>
References: <4A2F6D32.8030400@hartkopp.net>
	<20090610.015245.141342130.davem@davemloft.net>
	<200906102241.47823.jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: patchwork@ozlabs.org, netdev@vger.kernel.org, oliver@hartkopp.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 10 Jun 2009 22:41:47 +1000

> David,
> 
>> We really can't expect patchwork to look for every conceivable
>> malignment of the various reviewer tags.
> 
> No, but we could probably be more tolerant about capitalisation. Any 
> objections about ignoring case completely? I have a patch ready to 
> push...

Sure, sounds fine to me.
