Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wcQvT1spRzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 17:57:56 +1000 (AEST)
Date: Tue, 30 May 2017 09:57:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: mchehab@kernel.org, linux-edac@vger.kernel.org, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/3] EDAC: mv64x60: updates
Message-ID: <20170530075739.w3uzqw42lhwblwaw@pd.tnic>
References: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 30, 2017 at 09:21:39AM +1200, Chris Packham wrote:
> I'm looking at making use of the mv64x60_edac driver for the armada processors.
> It appears that at least the DRAM ECC error reporting is the same block from
> the old Marvell Discovery class of processors. On the ARM side I need to get
> the error interrupts exposed first before I can send my second set of changes
> for this driver but this first set is just a series of cleanups.
> 
> Chris Packham (3):
>   EDAC: mv64x60: check driver registration success
>   EDAC: mv64x60: Fix pdata->name
>   EDAC: mv64x60: replace in_le32/out_le32 with readl/writel
> 
>  drivers/edac/mv64x60_edac.c | 94 +++++++++++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 45 deletions(-)

All 3 applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
