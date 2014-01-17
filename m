Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1AAC2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 05:50:03 +1100 (EST)
Message-ID: <1389984587.24905.249.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/configs: Enbale Freescale IFC controller
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 17 Jan 2014 12:49:47 -0600
In-Reply-To: <B2E40837-4025-4975-8DAC-BB47E2B07E1A@kernel.crashing.org>
References: <1389938981-30858-1-git-send-email-prabhakar@freescale.com>
 <B2E40837-4025-4975-8DAC-BB47E2B07E1A@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-17 at 11:02 -0600, Kumar Gala wrote:
> On Jan 17, 2014, at 12:09 AM, Prabhakar Kushwaha <prabhakar@freescale.com> wrote:
> 
> > Currently IFC NAND driver is enabled in corenet32smp_defconfig. But IFC
> > controller is not enabled
> > 
> > So, Enable IFC controller in corenet32smp_defconfig.
> > 
> > Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> > ---
> > Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> > branch master
> > 
> > arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> > 1 file changed, 1 insertion(+)
> 
> Shouldn’t the NAND driver get the IFC controller enabled by Kconfig dependancies?

Yes (by select, not dependencies).

Prabhakar, was there an actual problem you saw before?  Did you run
savedefconfig after making this change?

CONFIG_FSL_IFC isn't even user-selectable (though it probably should be,
as how else would it get enabled in the absence of NAND for catching NOR
errors?).

-Scott
