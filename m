Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BCABDDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 14:04:32 +1000 (EST)
Subject: Re: [PATCH 1/4] [v4][POWERPC] refactor dcr code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080506134006.62900cce.sfr@canb.auug.org.au>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
	<20080506134006.62900cce.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 06 May 2008 14:02:11 +1000
Message-Id: <1210046531.21644.139.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-06 at 13:40 +1000, Stephen Rothwell wrote:
> Since find_dcr_parent has done a of_node_get on its return value, you
> leak a reference to dp here i.e. you need an of_node_put(dp) before
> you return.

He inherited that bug from other dcr.c functions I wrote, my fault.

Stephen (N. not R.), would you mind fixing them while at it or do you
want me to cook up a patch ?

Cheers,
Ben.
