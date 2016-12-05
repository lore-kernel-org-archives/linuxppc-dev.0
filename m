Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0073.outbound.protection.outlook.com [104.47.2.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXGB40fHNzDvPl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 18:10:35 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: kbuild test robot <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>, "oss@buserror.net"
 <oss@buserror.net>, "balbi@kernel.org" <balbi@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v9] QE: remove PPCisms for QE
Date: Mon, 5 Dec 2016 07:10:29 +0000
Message-ID: <AM3PR04MB11856965EF91B82754D8BCEB91830@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1480913809-23817-1-git-send-email-qiang.zhao@nxp.com>
 <201612051456.QmDg7mG4%fengguang.wu@intel.com>
In-Reply-To: <201612051456.QmDg7mG4%fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch depends on the patchset of QEIC as following links:
	http://patchwork.ozlabs.org/patch/675925/
	http://patchwork.ozlabs.org/patch/675926/
	http://patchwork.ozlabs.org/patch/675927/
	http://patchwork.ozlabs.org/patch/675928/

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Monday, December 05, 2016 3:00 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: kbuild-all@01.org; oss@buserror.net; balbi@kernel.org;
> gregkh@linuxfoundation.org; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-
> kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Qiang Zhao
> <qiang.zhao@nxp.com>
> Subject: Re: [PATCH v9] QE: remove PPCisms for QE
>=20
> Hi Zhao,
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.9-rc8]
> [cannot apply to next-20161202]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Zhao-Qiang/QE-remove-
> PPCisms-for-QE/20161205-131352
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from drivers/soc/fsl/qe/qe_ic.c:31:0:
>    include/soc/fsl/qe/qe_ic.h: In function 'qe_ic_cascade_low_ipic':
> >> include/soc/fsl/qe/qe_ic.h:86:21: error: 'NO_IRQ' undeclared (first us=
e in
> this function)
>      if (cascade_irq !=3D NO_IRQ)
>                         ^~~~~~
>    include/soc/fsl/qe/qe_ic.h:86:21: note: each undeclared identifier is =
reported
> only once for each function it appears in
>    include/soc/fsl/qe/qe_ic.h: In function 'qe_ic_cascade_high_ipic':
>    include/soc/fsl/qe/qe_ic.h:95:21: error: 'NO_IRQ' undeclared (first us=
e in this
> function)
>      if (cascade_irq !=3D NO_IRQ)
>                         ^~~~~~
>    include/soc/fsl/qe/qe_ic.h: In function 'qe_ic_cascade_low_mpic':
>    include/soc/fsl/qe/qe_ic.h:105:21: error: 'NO_IRQ' undeclared (first u=
se in
> this function)
>      if (cascade_irq !=3D NO_IRQ)
>                         ^~~~~~
>    include/soc/fsl/qe/qe_ic.h: In function 'qe_ic_cascade_high_mpic':
>    include/soc/fsl/qe/qe_ic.h:117:21: error: 'NO_IRQ' undeclared (first u=
se in
> this function)
>      if (cascade_irq !=3D NO_IRQ)
>                         ^~~~~~
>    include/soc/fsl/qe/qe_ic.h: In function 'qe_ic_cascade_muxed_mpic':
>    include/soc/fsl/qe/qe_ic.h:130:21: error: 'NO_IRQ' undeclared (first u=
se in
> this function)
>      if (cascade_irq =3D=3D NO_IRQ)
>                         ^~~~~~
>    drivers/soc/fsl/qe/qe_ic.c: In function 'qe_ic_read':
> >> drivers/soc/fsl/qe/qe_ic.c:180:9: error: implicit declaration of funct=
ion
> 'in_be32' [-Werror=3Dimplicit-function-declaration]
>      return in_be32(base + (reg >> 2));
>             ^~~~~~~
>    drivers/soc/fsl/qe/qe_ic.c: In function 'qe_ic_write':
> >> drivers/soc/fsl/qe/qe_ic.c:186:2: error: implicit declaration of funct=
ion
> 'out_be32' [-Werror=3Dimplicit-function-declaration]
>      out_be32(base + (reg >> 2), value);
>      ^~~~~~~~
>    drivers/soc/fsl/qe/qe_ic.c: In function 'qe_ic_get_low_irq':
> >> drivers/soc/fsl/qe/qe_ic.c:299:10: error: 'NO_IRQ' undeclared (first u=
se in
> this function)
>       return NO_IRQ;
>              ^~~~~~
>    drivers/soc/fsl/qe/qe_ic.c: In function 'qe_ic_get_high_irq':
>    drivers/soc/fsl/qe/qe_ic.c:315:10: error: 'NO_IRQ' undeclared (first u=
se in this
> function)
>       return NO_IRQ;
>              ^~~~~~
>    drivers/soc/fsl/qe/qe_ic.c: In function 'qe_ic_init':
>    drivers/soc/fsl/qe/qe_ic.c:350:25: error: 'NO_IRQ' undeclared (first u=
se in this
> function)
>      if (qe_ic->virq_low =3D=3D NO_IRQ) {
>                             ^~~~~~
>    drivers/soc/fsl/qe/qe_ic.c: In function 'qe_ic_set_highest_priority':
> >> drivers/soc/fsl/qe/qe_ic.c:392:21: error: implicit declaration of func=
tion
> 'virq_to_hw' [-Werror=3Dimplicit-function-declaration]
>      unsigned int src =3D virq_to_hw(virq);
>                         ^~~~~~~~~~
>    cc1: some warnings being treated as errors
>=20
> vim +/in_be32 +180 drivers/soc/fsl/qe/qe_ic.c
>=20
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  174
> 	.pri_reg =3D QEIC_CIPYCC,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  175
> 	},
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  176  };
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  177
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  178
> static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned in=
t reg)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  179  {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3 @180
> 	return in_be32(base + (reg >> 2));
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  181  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  182
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  183
> static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned =
int
> reg,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  184
> 		       u32 value)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  185  {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3 @186
> 	out_be32(base + (reg >> 2), value);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  187  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  188
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  189
> static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  190  {
> ec775d0e arch/powerpc/sysdev/qe_lib/qe_ic.c Thomas Gleixner     2011-03-2=
5
> 191  	return irq_get_chip_data(virq);
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 192  }
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 193
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 194  static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 195  {
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 196  	return irq_data_get_irq_chip_data(d);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  197  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  198
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 199  static void qe_ic_unmask_irq(struct irq_data *d)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  200  {
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 201  	struct qe_ic *qe_ic =3D qe_ic_from_irq_data(d);
> 476eb491 arch/powerpc/sysdev/qe_lib/qe_ic.c Grant Likely        2011-05-0=
4  202
> 	unsigned int src =3D irqd_to_hwirq(d);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  203
> 	unsigned long flags;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  204
> 	u32 temp;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  205
> 43a5a01b arch/powerpc/sysdev/qe_lib/qe_ic.c Anton Vorontsov     2010-02-1=
8
> 206  	raw_spin_lock_irqsave(&qe_ic_lock, flags);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  207
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  208
> 	temp =3D qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  209
> 	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  210
> 	    temp | qe_ic_info[src].mask);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  211
> 43a5a01b arch/powerpc/sysdev/qe_lib/qe_ic.c Anton Vorontsov     2010-02-1=
8
> 212  	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  213  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  214
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 215  static void qe_ic_mask_irq(struct irq_data *d)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  216  {
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 217  	struct qe_ic *qe_ic =3D qe_ic_from_irq_data(d);
> 476eb491 arch/powerpc/sysdev/qe_lib/qe_ic.c Grant Likely        2011-05-0=
4  218
> 	unsigned int src =3D irqd_to_hwirq(d);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  219
> 	unsigned long flags;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  220
> 	u32 temp;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  221
> 43a5a01b arch/powerpc/sysdev/qe_lib/qe_ic.c Anton Vorontsov     2010-02-1=
8
> 222  	raw_spin_lock_irqsave(&qe_ic_lock, flags);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  223
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  224
> 	temp =3D qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  225
> 	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  226
> 	    temp & ~qe_ic_info[src].mask);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  227
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  228
> 	/* Flush the above write before enabling interrupts; otherwise,
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  229
> 	 * spurious interrupts will sometimes happen.  To be 100% sure
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  230
> 	 * that the write has reached the device before interrupts are
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  231
> 	 * enabled, the mask register would have to be read back; however,
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  232
> 	 * this is not required for correctness, only to avoid wasting
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  233
> 	 * time on a large number of spurious interrupts.  In testing,
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  234
> 	 * a sync reduced the observed spurious interrupts to zero.
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  235
> 	 */
> 2c1d2f34 arch/powerpc/sysdev/qe_lib/qe_ic.c Scott Wood          2006-12-0=
6  236
> 	mb();
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  237
> 43a5a01b arch/powerpc/sysdev/qe_lib/qe_ic.c Anton Vorontsov     2010-02-1=
8
> 238  	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  239  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  240
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  241
> static struct irq_chip qe_ic_irq_chip =3D {
> b27df672 arch/powerpc/sysdev/qe_lib/qe_ic.c Thomas Gleixner     2009-11-1=
8
> 242  	.name =3D "QEIC",
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 243  	.irq_unmask =3D qe_ic_unmask_irq,
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 244  	.irq_mask =3D qe_ic_mask_irq,
> 3a0adfab arch/powerpc/sysdev/qe_lib/qe_ic.c Lennert Buytenhek   2011-03-0=
8
> 245  	.irq_mask_ack =3D qe_ic_mask_irq,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  246  };
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  247
> ad3aedfb arch/powerpc/sysdev/qe_lib/qe_ic.c Marc Zyngier        2015-07-2=
8
> 248  static int qe_ic_host_match(struct irq_domain *h, struct device_node
> *node,
> ad3aedfb arch/powerpc/sysdev/qe_lib/qe_ic.c Marc Zyngier        2015-07-2=
8
> 249  			    enum irq_domain_bus_token bus_token)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  250  {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  251
> 	/* Exact match, unless qe_ic node is NULL */
> 5d4c9bc7 arch/powerpc/sysdev/qe_lib/qe_ic.c Marc Zyngier        2015-10-1=
3
> 252  	struct device_node *of_node =3D irq_domain_get_of_node(h);
> 5d4c9bc7 arch/powerpc/sysdev/qe_lib/qe_ic.c Marc Zyngier        2015-10-1=
3
> 253  	return of_node =3D=3D NULL || of_node =3D=3D node;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  254  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  255
> bae1d8f1 arch/powerpc/sysdev/qe_lib/qe_ic.c Grant Likely        2012-02-1=
4  256
> static int qe_ic_host_map(struct irq_domain *h, unsigned int virq,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  257
> 		  irq_hw_number_t hw)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  258  {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  259
> 	struct qe_ic *qe_ic =3D h->host_data;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  260
> 	struct irq_chip *chip;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  261
> c9ee69c5 drivers/soc/fsl/qe/qe_ic.c         Zhao Qiang          2016-01-2=
1  262
> 	if (hw >=3D ARRAY_SIZE(qe_ic_info)) {
> c9ee69c5 drivers/soc/fsl/qe/qe_ic.c         Zhao Qiang          2016-01-2=
1  263
> 	pr_err("%s: Invalid hw irq number for QEIC\n", __func__);
> c9ee69c5 drivers/soc/fsl/qe/qe_ic.c         Zhao Qiang          2016-01-2=
1  264
> 	return -EINVAL;
> c9ee69c5 drivers/soc/fsl/qe/qe_ic.c         Zhao Qiang          2016-01-2=
1  265  	}
> c9ee69c5 drivers/soc/fsl/qe/qe_ic.c         Zhao Qiang          2016-01-2=
1  266
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  267
> 	if (qe_ic_info[hw].mask =3D=3D 0) {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  268
> 	printk(KERN_ERR "Can't map reserved IRQ\n");
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  269
> 	return -EINVAL;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  270  	}
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  271
> 	/* Default chip */
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  272
> 	chip =3D &qe_ic->hc_irq;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  273
> ec775d0e arch/powerpc/sysdev/qe_lib/qe_ic.c Thomas Gleixner     2011-03-2=
5
> 274  	irq_set_chip_data(virq, qe_ic);
> 98488db9 arch/powerpc/sysdev/qe_lib/qe_ic.c Thomas Gleixner     2011-03-2=
5
> 275  	irq_set_status_flags(virq, IRQ_LEVEL);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  276
> ec775d0e arch/powerpc/sysdev/qe_lib/qe_ic.c Thomas Gleixner     2011-03-2=
5
> 277  	irq_set_chip_and_handler(virq, chip, handle_level_irq);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  278
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  279
> 	return 0;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  280  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  281
> 202648a6 arch/powerpc/sysdev/qe_lib/qe_ic.c Krzysztof Kozlowski 2015-04-2=
7
> 282  static const struct irq_domain_ops qe_ic_host_ops =3D {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  283
> 	.match =3D qe_ic_host_match,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  284
> 	.map =3D qe_ic_host_map,
> ff8c3ab8 arch/powerpc/sysdev/qe_lib/qe_ic.c Grant Likely        2012-01-2=
4  285
> 	.xlate =3D irq_domain_xlate_onetwocell,
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  286  };
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  287
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  288  /*
> Return an interrupt vector or NO_IRQ if no interrupt is pending. */
> 35a84c2f arch/powerpc/sysdev/qe_lib/qe_ic.c Olaf Hering         2006-10-0=
7  289
> unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  290  {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  291
> 	int irq;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  292
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  293
> 	BUG_ON(qe_ic =3D=3D NULL);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  294
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  295
> 	/* get the interrupt source vector. */
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  296
> 	irq =3D qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  297
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  298
> 	if (irq =3D=3D 0)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3 @299
> 	return NO_IRQ;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  300
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  301
> 	return irq_linear_revmap(qe_ic->irqhost, irq);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  302  }
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  303
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  304  /*
> Return an interrupt vector or NO_IRQ if no interrupt is pending. */
> 35a84c2f arch/powerpc/sysdev/qe_lib/qe_ic.c Olaf Hering         2006-10-0=
7  305
> unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  306  {
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  307
> 	int irq;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  308
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  309
> 	BUG_ON(qe_ic =3D=3D NULL);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  310
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  311
> 	/* get the interrupt source vector. */
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  312
> 	irq =3D qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  313
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  314
> 	if (irq =3D=3D 0)
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3 @315
> 	return NO_IRQ;
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  316
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  317
> 	return irq_linear_revmap(qe_ic->irqhost, irq);
> 98658538 arch/powerpc/sysdev/qe_lib/qe_ic.c Li Yang             2006-10-0=
3  318  }
>=20
> :::::: The code at line 180 was first introduced by commit
> :::::: 9865853851313e0d94a4acde42d6f9d8070bb376 [POWERPC] Add QUICC
> Engine (QE) infrastructure
>=20
> :::::: TO: Li Yang <leoli@freescale.com>
> :::::: CC: Paul Mackerras <paulus@samba.org>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
