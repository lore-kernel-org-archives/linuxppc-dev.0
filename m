Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F17E2DE075
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 03:09:30 +1100 (EST)
Date: Thu, 6 Mar 2008 19:09:18 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] 8xx: fix swap
Message-ID: <20080306190918.04e2cee6@kernel.crashing.org>
In-Reply-To: <7E836D6E-867B-4A35-9B3D-CD1D52E7F2DC@kernel.crashing.org>
References: <20080306135330.6d5462d2@vitb.ru.mvista.com>
	<7E836D6E-867B-4A35-9B3D-CD1D52E7F2DC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 6 Mar 2008 09:56:58 -0600
Kumar Gala wrote:

> 
> On Mar 6, 2008, at 4:53 AM, Vitaly Bordug wrote:
> 
> > This makes swap routines operate correctly on the ppc_8xx based  
> > machines.
> > Code has been revalidated on mpc885ads (8M sdram) with recent  
> > kernel. Based
> > on patch from Yuri Tikhonov <yur@emcraft.com> to do the same on
> > arch/ ppc
> > instance.
> >
> > Recent kernel's size makes swap feature very important on
> > low-memory platforms,
> > those are actually non-operable without it.
> >
> > Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > ---
> >
> > arch/powerpc/kernel/head_8xx.S      |   30
> > ++++++++++++++++++++++++++ +++-
> > include/asm-powerpc/pgtable-ppc32.h |    8 --------
> > 2 files changed, 29 insertions(+), 9 deletions(-)
> 
> do we need similar fixes to arch/ppc ?
> 
there's patch from Yuri that does it for ppc/ - I guess you may just pick it up and place to your tree.

-- 
Sincerely, Vitaly
