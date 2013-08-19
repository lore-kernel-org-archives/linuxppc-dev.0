Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3CD0B2C0102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 09:47:28 +1000 (EST)
Message-ID: <1376956039.25016.103.camel@pasglop>
Subject: Re: Pull request: scottwood/linux.git next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 20 Aug 2013 09:47:19 +1000
In-Reply-To: <1376952992.31636.382.camel@snotra.buserror.net>
References: <20130808224501.GA8925@home.buserror.net>
 <1376453881.4255.57.camel@pasglop>
 <1376499759.31636.15.camel@snotra.buserror.net>
 <1376514060.4255.73.camel@pasglop>
 <1376952992.31636.382.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 17:56 -0500, Scott Wood wrote:
> If we use the generic CPU target then mftb won't get turned into mfspr
> (I assume this is what you meant by "tricky asm").  Does mfspr work
> everywhere, including from userspace?  Or do we need to patch?  What
> about 403GCX which seems to need some special SPR (I could leave the
> existing ifdef alone, but what about vdso)?

I think mfspr works everywhere we care about but I might be mistaken :-)
I don't think anybody have tried booting a 403 in a looooong time. I
would be surprised if it still worked.

Cheers,
Ben.
