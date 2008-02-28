Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id A710FDDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 23:51:22 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080227210003.484325295@gmail.com>
References: <20080227210003.484325295@gmail.com>
	<20080227205831.150784453@gmail.com>
To: gorcunov@gmail.com
Subject: Re: [RFC 05/10] mn10300: vmlinux.lds.S cleanup - use PAGE_SIZE,
	PERCPU macroses
Date: Thu, 28 Feb 2008 12:50:57 +0000
Message-ID: <21077.1204203057@redhat.com>
Sender: dhowells@redhat.com
Cc: chris@zankel.net, linux-m68k@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	jdike@addtoit.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, geert@linux-m68k.org,
	sam@ravnborg.org, takata@linux-m32r.org, rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gorcunov@gmail.com wrote:

> Subject: [RFC 05/10] mn10300: vmlinux.lds.S cleanup - use PAGE_SIZE, PERCPU macroses
> X-RedHat-Spam-Score: -1.005 
> 
> This patch includes page.h header into liker script that
> allow us to use PAGE_SIZE macro instead of numeric constant
> 
> Also PERCPU macro is used instead of explicit section definition
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Acked-by: David Howells <dhowells@redhat.com>
