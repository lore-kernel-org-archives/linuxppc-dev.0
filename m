Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7BFEADEC3E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:11:35 +1000 (EST)
Message-Id: <AA681CD4-C9BC-4643-8442-95C41A8CF82D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311172413.GC7727@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/8] [POWERPC] qe_lib: implement qe_muram_offset
Date: Mon, 14 Apr 2008 10:11:30 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172413.GC7727@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
> qe_muram_offset is the reverse of the qe_muram_addr, will be
> used for the Freescale QE USB Host Controller driver.
>
> This patch also moves qe_muram_addr into the qe.h header, plus
> adds __iomem hints to use with sparse.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |    8 +-------
> include/asm-powerpc/immap_qe.h  |    2 +-
> include/asm-powerpc/qe.h        |   11 ++++++++++-
> 3 files changed, 12 insertions(+), 9 deletions(-)

applied.

- k
