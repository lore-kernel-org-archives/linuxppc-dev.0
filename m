Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8FF501007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 08:23:14 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
Date: Tue, 30 Nov 2010 22:17:19 +0100
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
	<alpine.LFD.2.00.1011301455400.9313@xanadu.home>
In-Reply-To: <alpine.LFD.2.00.1011301455400.9313@xanadu.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201011302217.19596.arnd@arndb.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Daniel Walker <dwalker@codeaurora.org>, Mike Frysinger <vapier@gentoo.org>,
	Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 30 November 2010, Nicolas Pitre wrote:
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Cc: Mike Frysinger <vapier@gentoo.org>
> > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> This doesn't support both ARMv6 and ARMv7 at run time, but this can 
> trivially be added later when needed.

I was about to make a similar comment when I saw yours ;-)
