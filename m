Return-Path: <sebastian@breakpoint.cc>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54023B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 07:29:17 +1000 (EST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4CDDDDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 07:29:16 +1000 (EST)
Date: Wed, 5 Aug 2009 23:29:09 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/ipic: unmask all interrupt sources
Message-ID: <20090805212909.GB6233@Chamillionaire.breakpoint.cc>
References: <20090805194112.GA18204@www.tglx.de>
	<92176A7D-89C7-484F-B4C8-8E510271A512@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <92176A7D-89C7-484F-B4C8-8E510271A512@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kumar Gala | 2009-08-05 15:04:16 [-0500]:
>
> looks good.. I'll pick this up for .32 since it doesn't seem to be a bug 
> until we have kexec.
Well, the code for the non-mmu variant is there and is working. It was
just the ipic thing which was holding me back. However I'm fine with .32
I'm stocked here with .26.
The bigger issue is the user space for ppc32 which is non-working in
current upstream since it is pre-device tree and game cube only.
Once you have time to review the kernel interface (the part where we
jump to the new kernel / kernel wrapper) I could try to rebase my
patches and repost them :)

> - k

Sebastian
