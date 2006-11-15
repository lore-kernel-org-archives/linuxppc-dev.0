Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 4C9B967C56
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 04:28:13 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/16] hypervisor console for Celleb
Date: Wed, 15 Nov 2006 18:28:06 +0100
References: <200611150941.kAF9f85V004282@toshiba.co.jp>
In-Reply-To: <200611150941.kAF9f85V004282@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611151828.06691.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 November 2006 10:41, Ishizaki Kou wrote:
> This patch adds hypervisor console driver for Celleb platform.
> 
Nice small driver. Still, I'd like to know why there is no support
for interrupts to notify the kernel of incoming characters. This seems
to have the same (mis-)design as the IBM blade with the rtas console
that uses no interrupts.

	Arnd <><
