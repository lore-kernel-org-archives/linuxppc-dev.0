Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C891FDDF61
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 22:58:01 +1000 (EST)
Date: Thu, 5 Jun 2008 13:42:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: Linux 2.6.26-rc5
Message-ID: <20080605134222.76e117a4@core>
In-Reply-To: <20080605112436.GA4533@aepfle.de>
References: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
	<20080605112436.GA4533@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 13:24:36 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Wed, Jun 04, Linus Torvalds wrote:
> 
> > Another week, another batch of mostly pretty small fixes. Hopefully the 
> > regression list is shrinking, and we've fixed at least a couple of the 
> > oopses on Arjan's list.
> 
> SATA on a dualcore G5 is broken, it happend between

See the patch I just posted to Nick/Jeff should fix it. I always said
ata_sff_check_status() was asking for trouble as a name and neither I nor
Jeff nor Linus noticed the bug...
