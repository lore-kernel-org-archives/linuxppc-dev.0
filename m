Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id E493E2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 01:36:32 +1100 (EST)
Date: Wed, 3 Nov 2004 07:36:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Vladimir <vova-ks@yandex.ru>
Message-ID: <20041103073630.A3485@home.com>
References: <200411031241.40681.vova-ks@yandex.ru>
	<20041103065645.A3357@home.com>
	<200411031717.55398.vova-ks@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411031717.55398.vova-ks@yandex.ru>;
	from vova-ks@yandex.ru on Wed, Nov 03, 2004 at 05:17:55PM +0300
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kgdb on 405GP walnut-like board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 03, 2004 at 05:17:55PM +0300, Vladimir wrote:
> On Wednesday 03 November 2004 16:56, Matt Porter wrote:
> > No, it's not sufficient.  It helps to check the archives first.
> >
> > http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/000417.html
> > http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/000418.html
> I've tried this patch but it fails to apply (at least to 2.6.8.1 from 
> kernel.org). Am I to use another kernel version to apply this patch ?

The patch is against the current 2.6 BK tree, try patching a recent kernel
release like 2.6.10-rc1.
 
-Matt
