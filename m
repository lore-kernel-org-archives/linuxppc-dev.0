Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F22ABDE017
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 03:03:18 +1000 (EST)
Date: Tue, 23 Oct 2007 10:00:22 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH] Use the new sg_page() helper
In-Reply-To: <1193156092-11819-1-git-send-email-Emilian.Medve@Freescale.com>
Message-ID: <alpine.LFD.0.999.0710230956330.30120@woody.linux-foundation.org>
References: <1193156092-11819-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: axboe@kernel.dk, chris@zankel.net, grundler@parisc-linux.org,
	linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	shaohua.li@intel.com, linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@lists.parisc-linux.org, ashok.raj@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 23 Oct 2007, Emil Medve wrote:
>
> Fix build error messages such as this:

Some - but apparently not all - of these are already fixed in my tree, 
through pulls from Jens. I just pushed out the result, can you resend the 
parts that didn't already get fixed?

As is, the patch won't apply for me, since it touches many different parts 
and some of them are fixed.

		Linus
