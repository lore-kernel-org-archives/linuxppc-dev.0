Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83507.mail.sp1.yahoo.com (web83507.mail.sp1.yahoo.com
	[216.252.120.163]) by ozlabs.org (Postfix) with SMTP id 0F35FDDF11
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 07:13:43 +1000 (EST)
Date: Wed, 2 Jul 2008 14:13:42 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Kernel marking NAND blocks bad
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <486BDF26.2030006@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <634289.72892.qm@web83507.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank you (once again).  I found the information.

Ron
--- Scott Wood <scottwood@freescale.com> wrote:

> Ron Madrid wrote:
> > /* Large Page FLASH with FMR[ECCM] = 0 */
> > static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
> > 	.eccbytes = 12,
> > 	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
> > -	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
> > +	.oobfree = { {2, 4}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
> > 	.oobavail = 48,
> > };
> > 
> > /* Large Page FLASH with FMR[ECCM] = 1 */
> > static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
> > 	.eccbytes = 12,
> > 	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
> > -	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
> > +	.oobfree = { {2, 6}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
> > 	.oobavail = 48,
> > };
> 
> Anton's recent patchset (posted to the MTD list) should fix this.
> 
> -scott
> 
