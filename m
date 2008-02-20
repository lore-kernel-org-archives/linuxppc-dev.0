Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34C64DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 00:02:29 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1KD4MuR032688
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 08:04:22 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1KD2PeK388994
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 08:02:25 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1KD2PcJ012460
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 08:02:25 -0500
Date: Wed, 20 Feb 2008 07:01:19 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix Haleakala PCIe compatibility problem
	in dts
Message-ID: <20080220070119.27dc250d@zod.rchland.ibm.com>
In-Reply-To: <1203504358-21331-1-git-send-email-sr@denx.de>
References: <1203504358-21331-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Feb 2008 11:45:58 +0100
Stefan Roese <sr@denx.de> wrote:

> Since the 4xx PCIe driver checks for 405ex compatibility, the
> PCIe interface was not detected as it is currently defined as
> "405exr" compatible. This patch changes it to "405ex".
> 
> The 405EX and 405EXr are identical exept that the 2nd PCIe and the
> 2nd EMAC interfaces are missing.

Does ppc405ex_pciex_core_init need to grow some logic to detect 405ex
from 405exr and return the correct number of ports then?  It
unconditionally returns 2 today.

josh
