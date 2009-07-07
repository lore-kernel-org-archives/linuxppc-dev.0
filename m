Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A2A3AB7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 12:07:53 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5533BDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 12:07:52 +1000 (EST)
Date: Mon, 06 Jul 2009 19:07:53 -0700 (PDT)
Message-Id: <20090706.190753.85468651.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] net: fix OF fixed-link property handling on Freescale
	network device drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090703221851.23909.923.stgit@localhost.localdomain>
References: <20090703221851.23909.923.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, afleming@freescale.com, leoli@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 03 Jul 2009 16:20:19 -0600

> Anton, can you please review, comment and test?  I've tested it on an
> mpc8349 board, but that is the only hardware that I have.  I've also
> probably made mistakes and it needs to be split up into separate patches,
> but this is probably a sufficient form for first review.  I'll also give
> it another once over tomorrow when after I've had a decent night sleep.

Can we get some review and testing of this patch going so we
can fix this regression as soon as possible?

Thanks.
