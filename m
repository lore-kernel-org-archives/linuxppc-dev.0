Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C04E6868F
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Nov 2005 04:56:26 +1100 (EST)
Date: Sat, 5 Nov 2005 09:56:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-Id: <20051105095614.68fa5342.akpm@osdl.org>
In-Reply-To: <20051105175020.GZ3839@smtp.west.cox.net>
References: <20051103183256.GJ3839@smtp.west.cox.net>
	<20051104211605.2ccffef5.akpm@osdl.org>
	<20051105175020.GZ3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Allow for bigger compressed kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini <trini@kernel.crashing.org> wrote:
>
> If you
>  throw out an interm tree somewhere hopefully Matt can do a quick boot
>  test on some 4xx board (I unfortunaly don't have one).

OK.  I hope to have -mm1 out this weekend.  An interim tree at present
probably won't even vaguely compile.  Sigh.
