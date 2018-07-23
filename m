Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h22v4CzF07t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:14 +1000 (AEST)
In-Reply-To: <20180417091129.23069-2-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, mhairgrove@nvidia.com,
 arbab@linux.ibm.com
Subject: Re: [2/2] powernv/npu: Add a debugfs setting to change ATSD threshold
Message-Id: <41Z4h21rt3z9s2g@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-17 at 09:11:29 UTC, Alistair Popple wrote:
> The threshold at which it becomes more efficient to coalesce a range of
> ATSDs into a single per-PID ATSD is currently not well understood due to a
> lack of real-world work loads. This patch adds a debugfs parameter allowing
> the threshold to be altered at runtime in order to aid future development
> and refinement of the value.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/99c3ce33a00bc40cb218af770ef00c

cheers
