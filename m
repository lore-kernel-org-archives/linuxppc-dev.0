Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id B7775DDF75
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 22:04:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v3] usb: add Freescale QE/CPM USB peripheral controller
	driver
Date: Tue, 2 Sep 2008 14:01:24 +0200
References: <1220356690-8028-1-git-send-email-leoli@freescale.com>
In-Reply-To: <1220356690-8028-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809021401.25506.arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 September 2008, Li Yang wrote:
> Some of Freescale SoC chips have a QE or CPM co-processor which
> supports full speed USB.  The driver adds device mode support
> of both QE and CPM USB controller to Linux USB gadget.  The
> driver is tested with MPC8360 and MPC8272, and should work with
> other models having QE/CPM given minor tweaks.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

All my previous review comments have been addressed.

> +	udc_controller->soc_type = (unsigned long)np->data;

I'm not sure about this line, shouldn't that be
	udc_controller->soc_type = (unsigned long)match->data; ?

	Arnd <><
