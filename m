Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72C501A1059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:02 +1000 (AEST)
In-Reply-To: <1435574111-45617-1-git-send-email-maninder1.s@samsung.com>
To: Maninder Singh <maninder1.s@samsung.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Maninder Singh <maninder1.s@samsung.com>, pankaj.m@samsung.com
Subject: Re: [1/1] cxl/vphb.c: Use phb pointer after NULL check
Message-Id: <20150707103802.4FD821401EF@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-29-06 at 10:35:11 UTC, Maninder Singh wrote:
> static Anlaysis detected below error:-
> (error) Possible null pointer dereference: phb
> 
> So, Use phb after NULL check.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=14f21189df33bc972455d6a0ed875aa68718d7fc

cheers
