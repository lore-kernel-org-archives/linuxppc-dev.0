Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 641C5B70AA
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 11:37:52 +1000 (EST)
Date: Mon, 26 Jul 2010 18:38:08 -0700 (PDT)
Message-Id: <20100726.183808.15223674.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
	of_node_to_nid()
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z@mail.gmail.com>
References: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
	<20100726.154854.35052662.davem@davemloft.net>
	<AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 16:51:01 -0600

> Indeed.  I looked at it briefly, but it wasn't immediately clear what
> the impact would be to switch powerpc over to -1, and it looked to me
> like sparc depends on -1 to signify no node association.

Kernel wide, NUMA interfaces tend to take "-1" to mean "any node."

I had looked over the powerpc cases, and besides 1 or 2 strange
locations the powerpc call sites were ready to handle -1.
