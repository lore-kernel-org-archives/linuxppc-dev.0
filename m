Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 007DADEF64
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 03:12:36 +1000 (EST)
Message-ID: <47FF9BFE.5000201@freescale.com>
Date: Fri, 11 Apr 2008 12:12:30 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
References: <20080311171045.GB4684@localhost.localdomain>
	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
	<47FF9665.7020403@freescale.com>
	<20080411170657.GA15270@polina.dev.rtsoft.ru>
	<20080411171109.GA16119@polina.dev.rtsoft.ru>
In-Reply-To: <20080411171109.GA16119@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Or maybe I'm thinking here in terms of "fsl,ucc"... and cell-index is
> indeed should be -1... don't know. Please decide. ;-)

Well, that's what I was thinking.  cell-index is zero-based, so UCC1 should have
cell-index = <0>.

Of course, this means all the code needs to change, since I think device-id is
one-based.

-- 
Timur Tabi
Linux kernel developer at Freescale
