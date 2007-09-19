Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18160.43591.441863.931220@cargo.ozlabs.ibm.com>
Date: Wed, 19 Sep 2007 14:49:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix build errors when BLOCK=n
In-Reply-To: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
References: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@Freescale.com, bzolnier@gmail.com,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Emil Medve writes:

> The fix tries to use the smallest scope CONFIG_* symbols that will fix the build
> problem. In this case <linux/ide.h> needs to be included only if IDE=y or
> IDE=m were selected. Also, ppc_ide_md is needed only if BLK_DEV_IDE=y or
> BLK_DEV_IDE=m

It would be nicer to remove the ppc_ide_md stuff from ppc_ksyms.c
altogether and just put the EXPORT_SYMBOL in setup_32.c.

Paul.
