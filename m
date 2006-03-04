Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8B0867A03
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Mar 2006 02:32:00 +1100 (EST)
Date: Sat, 4 Mar 2006 16:31:55 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: incorrect rmo_top handling in prom_init
Message-ID: <20060304153155.GA6763@suse.de>
References: <20060302185509.GA14235@suse.de>
	<1141342541.13565.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1141342541.13565.6.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Benjamin Herrenschmidt wrote:

> On Thu, 2006-03-02 at 19:55 +0100, Olaf Hering wrote:
> > My iBook1 has 2 memory regions in reg. Depending on how I boot it
> > (vmlinux+initrd) or zImage.initrd, it will not boot with current Linus
> > tree.
> > rmo_top should be 160MB instead of 32MB.
> 
> Does that fix it ?

Yes.
