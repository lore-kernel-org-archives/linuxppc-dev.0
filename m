Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 86C33DE4C3
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 03:18:43 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KpmJW-0001Ka-Ck
	for linuxppc-dev@ozlabs.org; Tue, 14 Oct 2008 16:00:02 +0000
Received: from ppp91-122-81-211.pppoe.avangarddsl.ru ([91.122.81.211])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 16:00:02 +0000
Received: from dbaryshkov by ppp91-122-81-211.pppoe.avangarddsl.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 16:00:02 +0000
To: linuxppc-dev@ozlabs.org
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu	MB862xx GDCs
Date: Tue, 14 Oct 2008 15:50:52 +0000 (UTC)
Message-ID: <gd2f4s$82f$1@ger.gmane.org>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@ger.gmane.org>
Cc: linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:

> This patch adds framebuffer driver for Fujitsu Carmine/Coral-P(A)/Lime
> graphics controllers. Lime GDC support is known to work on PPC440EPx
> based lwmon5 and MPC8544E based socrates embedded boards, both equipped
> with Lime GDC. Carmine/Coral-P PCI GDC support is known to work on
> PPC440EPx based Sequoia board and also on x86 platform.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de> ---
> There are some PPC OF bits, so I'm cc'ing linuxppc-dev list.

I though there is already carminefb driver. Probably you should either merge
them or state that carminefb should be dropped.

-- 
With best wishes
Dmitry
