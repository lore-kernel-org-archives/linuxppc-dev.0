Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL66Bn0zDqBl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:34 +1100 (AEDT)
In-Reply-To: <1484023304-17244-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: powerpc/powernv: Use OPAL call for TCE kill on NVLink2
Message-Id: <3vClL56kqyz9t17@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-10 at 04:41:44 UTC, Alistair Popple wrote:
> Add detection of NPU2 PHBs. NPU2/NVLink2 has a different register
> layout for the TCE kill register therefore TCE invalidation should be
> done via the OPAL call rather than using the register directly as it
> is for PHB3 and NVLink1. This changes TCE invalidation to use the OPAL
> call in the case of a NPU2 PHB model.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/616badd2fb499320d3ac3b54462f55

cheers
