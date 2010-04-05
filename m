Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D0024B7D0E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 05:16:46 +1000 (EST)
Date: Mon, 05 Apr 2010 12:16:47 -0700 (PDT)
Message-Id: <20100405.121647.91426186.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] [V2] Add non-Virtex5 support for LL TEMAC driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <q2xfa686aa41004051110hc960e9a0sd1d5e61f7e2a5412@mail.gmail.com>
References: <bda26c8d-00b2-411d-b4b7-ad6954b9049e@SG2EHSMHS005.ehs.local>
	<fa686aa41003171302v46738069pae51061ba83d0818@mail.gmail.com>
	<q2xfa686aa41004051110hc960e9a0sd1d5e61f7e2a5412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jtyner@cs.ucr.edu,
	michal.simek@petalogix.com, john.linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Apr 2010 12:10:51 -0600

> David, are you going to pick up this patch, or would you like me to?

The submitter, when asked, stated that he couldn't even get
the driver to build on microblaze against mainline.

So I marked the patch "changed requested" because being able
to build is... you know... sort of a requirement for integration.
