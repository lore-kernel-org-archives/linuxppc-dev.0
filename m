Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id 2CBA6DDE29
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 06:27:53 +1000 (EST)
Subject: Re: CONFIG_BLK_DEV_BSG=n
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27015558EA@az33exm24.fsl.freescale.net>
References: <598D5675D34BE349929AF5EDE9B03E27015558EA@az33exm24.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 15:00:08 -0500
Message-Id: <1189800008.3343.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	Gala Kumar-B11780 <kumar.gala@freescale.com>, paulus@samba.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-09-14 at 12:50 -0700, Medve Emilian-EMMEDVE1 wrote:
> Which solution would you be more comfortable with?

The one which is currently in -mm is this one:

http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=49892223f7d3a2333ef9e6cbdd526676e1fc517a

James
