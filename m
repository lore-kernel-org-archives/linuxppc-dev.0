Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Bv12VJzF0Zv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:25:59 +1100 (AEDT)
In-Reply-To: <20180115133003.3447-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, "Tobin C. Harding" <me@tobin.cc>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: include linux/types.h in asm/hvcall.h
Message-Id: <3zM7Bt5g6Zz9sP1@ozlabs.org>
Date: Thu, 18 Jan 2018 00:25:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-01-15 at 13:30:03 UTC, Michal Suchanek wrote:
> Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
> settings") uses u64 in asm/hvcall.h without including linux/types.h
> 
> This breaks hvcall.h users that do not include the header themselves.
> 
> Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
>     settings")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1b689a95ce7427075f9ac9fb4aea1a

cheers
