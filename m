Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 12/14] powerpc: Move get_longbusy_msecs into hvcall.h and
 remove duplicate function
In-reply-to: <20121109202655.3a2b2876b97b39c581a36637@canb.auug.org.au>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
 <1352441953-29096-14-git-send-email-mikey@neuling.org>
 <20121109202655.3a2b2876b97b39c581a36637@canb.auug.org.au>
Date: Fri, 09 Nov 2012 20:49:53 +1100
Message-ID: <2392.1352454593@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Mikey,
> 
> On Fri,  9 Nov 2012 17:19:11 +1100 Michael Neuling <mikey@neuling.org> wrote:
> >
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > I am going to use this in the next patch, better to have this code in
> > one place rather than three.
> > 
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/include/asm/hvcall.h         |   20 ++++++++++++++++++++
> >  drivers/infiniband/hw/ehca/hcp_if.c       |   20 --------------------
> >  drivers/net/ethernet/ibm/ehea/ehea_phyp.h |   20 --------------------
> >  3 files changed, 20 insertions(+), 40 deletions(-)
> 
> This is identical to patch 10/14 ...

Actually, it's the same as 10/12.  Looks like i didn't clear out my send
directory correctly.

10/14 is correct.

Thanks,
Mikey
