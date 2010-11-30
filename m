Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id E4D081007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 07:57:55 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0LCP00LQGRFYDD70@vl-mh-mrz21.ip.videotron.ca> for
	linuxppc-dev@lists.ozlabs.org; Tue, 30 Nov 2010 14:57:35 -0500 (EST)
Date: Tue, 30 Nov 2010 14:57:48 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
In-reply-to: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
Message-id: <alpine.LFD.2.00.1011301455400.9313@xanadu.home>
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	linux-arm-msm@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
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

On Tue, 30 Nov 2010, Daniel Walker wrote:

> This driver adds a basic console that uses the arm JTAG
> DCC to transfer data back and forth. It has support for
> ARMv6 and ARMv7.
> 
> This console is created under the HVC driver, and should be named
> /dev/hvcX (or /dev/hvc0 for example).
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

This doesn't support both ARMv6 and ARMv7 at run time, but this can 
trivially be added later when needed.


Nicolas
