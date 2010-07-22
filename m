Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6178E100BE2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 15:28:36 +1000 (EST)
Date: Wed, 21 Jul 2010 22:28:52 -0700 (PDT)
Message-Id: <20100721.222852.08977036.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 5/5] of: remove asm/of_device.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100721234015.7782.98378.stgit@angua>
References: <20100721232817.7782.23410.stgit@angua>
	<20100721234015.7782.98378.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 17:40:15 -0600

> It is mostly unused now.  Sparc has a few defines left in it, but they
> can be moved to other headers.  Removing this header means that new
> architectures adding CONFIG_OF support don't need to also add this
> header file.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
