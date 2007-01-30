Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id BC7FDDDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 16:39:28 +1100 (EST)
Date: Mon, 29 Jan 2007 22:17:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] generic RTC support for PPC
Message-ID: <20070130051736.GH28746@smtp.west.cox.net>
References: <20070125073754.GA10004@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070125073754.GA10004@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 01:37:54AM -0600, Olof Johansson wrote:

> Make the PPC RTC functions use the generic RTC infrastructure if they
> are not already defined (and an RTC is registered in the system).
> 
> This should make it possible to remove the hideous direct access used
> in some of the 83xx platforms.

Now, I know I'm a bit late, and I've been quiet of late, but, um, why is
there anything other than the RTC class stuff being used?  I know
drivers/char/genrtc.c isn't gone yet, but really, it should be in the
process of being phased out.  IMHO, it should depend on !POWERPC (or
whatever the magic is to allow arch/ppc && !arch/powerpc).

-- 
Tom Rini
