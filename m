Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LNg975k4zF324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 15:30:11 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id z3-v6so1066115wrr.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:30:11 -0700 (PDT)
Date: Thu, 27 Sep 2018 07:30:03 +0200
From: LABBE Corentin <clabbe@baylibre.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com,
 khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] powerpc: rename setbits32/clrbits32 to
 setbits32_be/clrbits32_be
Message-ID: <20180927053003.GA27637@Red>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-2-git-send-email-clabbe@baylibre.com>
 <eeaeff10-dcc9-ab50-5d54-4d727f12d584@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <eeaeff10-dcc9-ab50-5d54-4d727f12d584@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2018 at 06:56:23AM +0200, Christophe LEROY wrote:
> Fix the patch title.
> 
> 
> Le 24/09/2018 à 21:04, Corentin Labbe a écrit :
> > Since setbits32/clrbits32 work on be32, it's better to remove ambiguity on
> > the used data type.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   arch/powerpc/include/asm/fsl_lbc.h               |  2 +-
> >   arch/powerpc/include/asm/io.h                    |  5 +-
> >   arch/powerpc/platforms/44x/canyonlands.c         |  4 +-
> >   arch/powerpc/platforms/4xx/gpio.c                | 28 ++++-----
> >   arch/powerpc/platforms/512x/pdm360ng.c           |  6 +-
> >   arch/powerpc/platforms/52xx/mpc52xx_common.c     |  6 +-
> >   arch/powerpc/platforms/52xx/mpc52xx_gpt.c        | 10 ++--
> >   arch/powerpc/platforms/82xx/ep8248e.c            |  2 +-
> >   arch/powerpc/platforms/82xx/km82xx.c             |  6 +-
> >   arch/powerpc/platforms/82xx/mpc8272_ads.c        | 10 ++--
> >   arch/powerpc/platforms/82xx/pq2.c                |  2 +-
> >   arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |  4 +-
> >   arch/powerpc/platforms/82xx/pq2fads.c            | 10 ++--
> >   arch/powerpc/platforms/83xx/km83xx.c             |  6 +-
> >   arch/powerpc/platforms/83xx/mpc836x_mds.c        |  2 +-
> >   arch/powerpc/platforms/85xx/mpc85xx_mds.c        |  2 +-
> >   arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c     |  4 +-
> >   arch/powerpc/platforms/85xx/mpc85xx_rdb.c        |  2 +-
> >   arch/powerpc/platforms/85xx/p1022_ds.c           |  4 +-
> >   arch/powerpc/platforms/85xx/p1022_rdk.c          |  4 +-
> >   arch/powerpc/platforms/85xx/t1042rdb_diu.c       |  4 +-
> >   arch/powerpc/platforms/85xx/twr_p102x.c          |  2 +-
> >   arch/powerpc/platforms/86xx/mpc8610_hpcd.c       |  4 +-
> >   arch/powerpc/platforms/8xx/adder875.c            |  2 +-
> >   arch/powerpc/platforms/8xx/m8xx_setup.c          |  4 +-
> >   arch/powerpc/platforms/8xx/mpc86xads_setup.c     |  4 +-
> >   arch/powerpc/platforms/8xx/mpc885ads_setup.c     | 28 ++++-----
> >   arch/powerpc/platforms/embedded6xx/flipper-pic.c |  6 +-
> >   arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |  8 +--
> >   arch/powerpc/platforms/embedded6xx/wii.c         | 10 ++--
> >   arch/powerpc/sysdev/cpm1.c                       | 26 ++++-----
> >   arch/powerpc/sysdev/cpm2.c                       | 16 ++---
> >   arch/powerpc/sysdev/cpm_common.c                 |  4 +-
> >   arch/powerpc/sysdev/fsl_85xx_l2ctlr.c            |  8 +--
> >   arch/powerpc/sysdev/fsl_lbc.c                    |  2 +-
> >   arch/powerpc/sysdev/fsl_pci.c                    |  8 +--
> >   arch/powerpc/sysdev/fsl_pmc.c                    |  2 +-
> >   arch/powerpc/sysdev/fsl_rcpm.c                   | 74 ++++++++++++------------
> >   arch/powerpc/sysdev/fsl_rio.c                    |  4 +-
> >   arch/powerpc/sysdev/fsl_rmu.c                    |  8 +--
> >   arch/powerpc/sysdev/mpic_timer.c                 | 12 ++--
> >   41 files changed, 178 insertions(+), 177 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
> > index c7240a024b96..4d6a56b48a28 100644
> > --- a/arch/powerpc/include/asm/fsl_lbc.h
> > +++ b/arch/powerpc/include/asm/fsl_lbc.h
> > @@ -276,7 +276,7 @@ static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u8 pat_offset)
> >    */
> >   static inline void fsl_upm_end_pattern(struct fsl_upm *upm)
> >   {
> > -	clrbits32(upm->mxmr, MxMR_OP_RP);
> > +	clrbits_be32(upm->mxmr, MxMR_OP_RP);
> >   
> >   	while (in_be32(upm->mxmr) & MxMR_OP_RP)
> >   		cpu_relax();
> > diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> > index e0331e754568..57486a1b9992 100644
> > --- a/arch/powerpc/include/asm/io.h
> > +++ b/arch/powerpc/include/asm/io.h
> > @@ -873,8 +873,8 @@ static inline void * bus_to_virt(unsigned long address)
> >   #endif /* CONFIG_PPC32 */
> >   
> >   /* access ports */
> > -#define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
> > -#define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
> > +#define setbits_be32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
> > +#define clrbits_be32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
> >   
> >   #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
> >   #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
> > @@ -904,6 +904,7 @@ static inline void * bus_to_virt(unsigned long address)
> >   #define clrsetbits_le16(addr, clear, set) clrsetbits(le16, addr, clear, set)
> >   
> >   #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
> > +#define clrsetbits_be32(addr, clear, set) clrsetbits(be32, addr, clear, set)
> 
> This one already exists a few lines above.
> 
> >   
> >   #endif /* __KERNEL__ */
> >   
> > diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
> > index 157f4ce46386..6aeb4ca64d09 100644
> > --- a/arch/powerpc/platforms/44x/canyonlands.c
> > +++ b/arch/powerpc/platforms/44x/canyonlands.c
> > @@ -113,8 +113,8 @@ static int __init ppc460ex_canyonlands_fixup(void)
> >   	 * USB2HStop and gpio19 will be USB2DStop. For more details refer to
> >   	 * table 34-7 of PPC460EX user manual.
> >   	 */
> > -	setbits32((vaddr + GPIO0_OSRH), 0x42000000);
> > -	setbits32((vaddr + GPIO0_TSRH), 0x42000000);
> > +	setbits_be32((vaddr + GPIO0_OSRH), 0x42000000);
> > +	setbits_be32((vaddr + GPIO0_TSRH), 0x42000000);
> >   err_gpio:
> >   	iounmap(vaddr);
> >   err_bcsr:
> > diff --git a/arch/powerpc/platforms/4xx/gpio.c b/arch/powerpc/platforms/4xx/gpio.c
> > index 2238e369cde4..8436da0617fd 100644
> > --- a/arch/powerpc/platforms/4xx/gpio.c
> > +++ b/arch/powerpc/platforms/4xx/gpio.c
> > @@ -82,9 +82,9 @@ __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> >   	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> >   
> >   	if (val)
> > -		setbits32(&regs->or, GPIO_MASK(gpio));
> > +		setbits_be32(&regs->or, GPIO_MASK(gpio));
> >   	else
> > -		clrbits32(&regs->or, GPIO_MASK(gpio));
> > +		clrbits_be32(&regs->or, GPIO_MASK(gpio));
> >   }
> >   
> >   static void
> > @@ -112,18 +112,18 @@ static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> >   	spin_lock_irqsave(&chip->lock, flags);
> >   
> >   	/* Disable open-drain function */
> > -	clrbits32(&regs->odr, GPIO_MASK(gpio));
> > +	clrbits_be32(&regs->odr, GPIO_MASK(gpio));
> >   
> >   	/* Float the pin */
> > -	clrbits32(&regs->tcr, GPIO_MASK(gpio));
> > +	clrbits_be32(&regs->tcr, GPIO_MASK(gpio));
> >   
> >   	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
> >   	if (gpio < 16) {
> > -		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
> > -		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->osrl, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->tsrl, GPIO_MASK2(gpio));
> >   	} else {
> > -		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
> > -		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->osrh, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->tsrh, GPIO_MASK2(gpio));
> >   	}
> >   
> >   	spin_unlock_irqrestore(&chip->lock, flags);
> > @@ -145,18 +145,18 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> >   	__ppc4xx_gpio_set(gc, gpio, val);
> >   
> >   	/* Disable open-drain function */
> > -	clrbits32(&regs->odr, GPIO_MASK(gpio));
> > +	clrbits_be32(&regs->odr, GPIO_MASK(gpio));
> >   
> >   	/* Drive the pin */
> > -	setbits32(&regs->tcr, GPIO_MASK(gpio));
> > +	setbits_be32(&regs->tcr, GPIO_MASK(gpio));
> >   
> >   	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
> >   	if (gpio < 16) {
> > -		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
> > -		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->osrl, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->tsrl, GPIO_MASK2(gpio));
> >   	} else {
> > -		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
> > -		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->osrh, GPIO_MASK2(gpio));
> > +		clrbits_be32(&regs->tsrh, GPIO_MASK2(gpio));
> >   	}
> >   
> >   	spin_unlock_irqrestore(&chip->lock, flags);
> > diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
> > index dc81f05e0bce..06b95795267a 100644
> > --- a/arch/powerpc/platforms/512x/pdm360ng.c
> > +++ b/arch/powerpc/platforms/512x/pdm360ng.c
> > @@ -38,7 +38,7 @@ static int pdm360ng_get_pendown_state(void)
> >   
> >   	reg = in_be32(pdm360ng_gpio_base + 0xc);
> >   	if (reg & 0x40)
> > -		setbits32(pdm360ng_gpio_base + 0xc, 0x40);
> > +		setbits_be32(pdm360ng_gpio_base + 0xc, 0x40);
> >   
> >   	reg = in_be32(pdm360ng_gpio_base + 0x8);
> >   
> > @@ -69,8 +69,8 @@ static int __init pdm360ng_penirq_init(void)
> >   		return -ENODEV;
> >   	}
> >   	out_be32(pdm360ng_gpio_base + 0xc, 0xffffffff);
> > -	setbits32(pdm360ng_gpio_base + 0x18, 0x2000);
> > -	setbits32(pdm360ng_gpio_base + 0x10, 0x40);
> > +	setbits_be32(pdm360ng_gpio_base + 0x18, 0x2000);
> > +	setbits_be32(pdm360ng_gpio_base + 0x10, 0x40);
> >   
> >   	return 0;
> >   }
> > diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> > index 565e3a83dc9e..edfe619d67bf 100644
> > --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> > +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> > @@ -314,13 +314,13 @@ int mpc5200_psc_ac97_gpio_reset(int psc_number)
> >   
> >   	/* enable gpio pins for output */
> >   	setbits8(&wkup_gpio->wkup_gpioe, reset);
> > -	setbits32(&simple_gpio->simple_gpioe, sync | out);
> > +	setbits_be32(&simple_gpio->simple_gpioe, sync | out);
> >   
> >   	setbits8(&wkup_gpio->wkup_ddr, reset);
> > -	setbits32(&simple_gpio->simple_ddr, sync | out);
> > +	setbits_be32(&simple_gpio->simple_ddr, sync | out);
> >   
> >   	/* Assert cold reset */
> > -	clrbits32(&simple_gpio->simple_dvo, sync | out);
> > +	clrbits_be32(&simple_gpio->simple_dvo, sync | out);
> >   	clrbits8(&wkup_gpio->wkup_dvo, reset);
> >   
> >   	/* wait for 1 us */
> > diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > index 17cf249b18ee..e9f4dec06077 100644
> > --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > @@ -142,7 +142,7 @@ static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
> >   	unsigned long flags;
> >   
> >   	raw_spin_lock_irqsave(&gpt->lock, flags);
> > -	setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
> > +	setbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
> >   	raw_spin_unlock_irqrestore(&gpt->lock, flags);
> >   }
> >   
> > @@ -152,7 +152,7 @@ static void mpc52xx_gpt_irq_mask(struct irq_data *d)
> >   	unsigned long flags;
> >   
> >   	raw_spin_lock_irqsave(&gpt->lock, flags);
> > -	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
> > +	clrbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
> >   	raw_spin_unlock_irqrestore(&gpt->lock, flags);
> >   }
> >   
> > @@ -308,7 +308,7 @@ static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> >   	dev_dbg(gpt->dev, "%s: gpio:%d\n", __func__, gpio);
> >   
> >   	raw_spin_lock_irqsave(&gpt->lock, flags);
> > -	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK);
> > +	clrbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK);
> >   	raw_spin_unlock_irqrestore(&gpt->lock, flags);
> >   
> >   	return 0;
> > @@ -482,7 +482,7 @@ int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
> >   		return -EBUSY;
> >   	}
> >   
> > -	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
> > +	clrbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
> >   	raw_spin_unlock_irqrestore(&gpt->lock, flags);
> >   	return 0;
> >   }
> > @@ -639,7 +639,7 @@ static int mpc52xx_wdt_release(struct inode *inode, struct file *file)
> >   	unsigned long flags;
> >   
> >   	raw_spin_lock_irqsave(&gpt_wdt->lock, flags);
> > -	clrbits32(&gpt_wdt->regs->mode,
> > +	clrbits_be32(&gpt_wdt->regs->mode,
> >   		  MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
> 
> The alignment needs to be fixed here (and all other places). The second 
> line should start under the &
> Eventually use checkpatch to locate all places that need to be fixed. 
> (checkpatch may even fix it for you)
> 

Thanks, I will fix all reported problem
