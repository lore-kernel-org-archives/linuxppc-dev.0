Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 15/17] powerpc: Add config option for transactional memory
In-reply-to: <2AEBB52F-9DB5-4211-9DA7-B1D271F1D6E8@kernel.crashing.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
 <1360729895-304-16-git-send-email-mikey@neuling.org>
 <2AEBB52F-9DB5-4211-9DA7-B1D271F1D6E8@kernel.crashing.org>
Date: Thu, 14 Feb 2013 12:52:32 +1100
Message-ID: <5806.1360806752@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Feb 12, 2013, at 10:31 PM, Michael Neuling wrote:
> 
> > Kconfig option for transactional memory on powerpc.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > arch/powerpc/Kconfig |    8 ++++++++
> > 1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 4b27edb..fbeb6d2 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -313,6 +313,14 @@ config MATH_EMULATION
> > 	  unit, which will allow programs that use floating-point
> > 	  instructions to run.
> > 
> > +config PPC_TRANSACTIONAL_MEM
> > +       bool "Transactional Memory support for POWERPC"
> > +       depends on PPC64
> 
> Should this really depend on PPC_BOOK3S_64 ?

OK, thanks.

Mikey
