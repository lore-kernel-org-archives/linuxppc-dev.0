Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 315F5DE1AA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 01:21:16 +1100 (EST)
Message-ID: <48F5FC55.4000708@denx.de>
Date: Wed, 15 Oct 2008 16:21:09 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
References: <1223997906-19900-1-git-send-email-agust@denx.de>
	<48F5F2BF.2040805@selcomgroup.com>
In-Reply-To: <48F5F2BF.2040805@selcomgroup.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matteo Fortini wrote:

> What about the mb86290 framebuffer driver directly from Fujitsu which is
> in the mainline kernel?

This mb86290 framebuffer driver from Fujitsu isn't in mainline, it
is in the DENX Linux Kernel tree.

> It's from 2003 and supports only until 86293, but can it be used as a
> basis for a proper fb driver? It has a lot of features indeed...

I think it won't be accepted in mainline. It was developed for 2.4
Kernel and slightly modified for 2.6. These features could be added
to the new driver which is intended to provide initial support for
Fujitsu GDCs in mainline now.

Anatolij
