Return-Path: <jdike@addtoit.com>
Received: from saraswathi.solana.com (unknown [198.99.130.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEE25DDE3F
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 03:15:37 +1100 (EST)
Date: Fri, 29 Feb 2008 10:43:03 -0500
From: Jeff Dike <jdike@addtoit.com>
To: gorcunov@gmail.com
Subject: Re: [RFC 08/10] um: dyn/uml.lds.S cleanup - use PAGE_SIZE macro
Message-ID: <20080229154303.GC5886@c2.user-mode-linux.org>
References: <20080227205831.150784453@gmail.com>
	<20080227210004.189002678@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080227210004.189002678@gmail.com>
Cc: chris@zankel.net, linux-m68k@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, geert@linux-m68k.org,
	sam@ravnborg.org, rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 27, 2008 at 11:58:39PM +0300, gorcunov@gmail.com wrote:
> This patch includes page.h header into liker scripts that
> allow us to use PAGE_SIZE macro instead of numeric constant.
> 
> To be able to include page.h into linker scripts page.h is
> needed for some modification - i.e. we need to use __ASSEMBLY__
> and _AC macro
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Needed some fixing, but it's OK.  I'll forward it on.

       	    	    	Jeff

-- 
Work email - jdike at linux dot intel dot com
