Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5311F1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 13:58:44 +1000 (AEST)
In-Reply-To: <1433129204-25878-1-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [V3] drivers/mtd: add powernv flash MTD abstraction driver
Message-Id: <20150602035844.331071412F1@ozlabs.org>
Date: Tue,  2 Jun 2015 13:58:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-06 at 03:26:44 UTC, Cyril Bur wrote:
> Powerpc powernv platforms allow access to certain system flash devices
> through a firmwarwe interface. This change adds an mtd driver for these
> flash devices.
> 
> Minor updates from Jeremy Kerr and Joel Stanley.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
> V2: Address Brian Norris' review
>     Fix typos
>     Change from NAND flash type to NOR flash type
>     Correctness tweaks
> V3: Address Neelesh Gupta's review
>     Minor corrections
>     Release the opal token on error
>     Unregister mtd device on module remove


You seem to have dropped Brian and linux-mtd from Cc?

Please put them back and repost, with a request for an ACK so we can take it
via the powerpc tree.

cheers
