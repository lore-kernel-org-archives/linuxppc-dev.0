Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id B536C67BB5
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 00:15:12 +1000 (EST)
Date: Thu, 21 Sep 2006 16:14:51 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IDE not found on Performa due to interrupt breakage
Message-ID: <20060921141451.GA17791@aepfle.de>
References: <20060921115030.GA16732@aepfle.de>
	<1158839781.26347.106.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1158839781.26347.106.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, Benjamin Herrenschmidt wrote:

> On Thu, 2006-09-21 at 13:50 +0200, Olaf Hering wrote:
> > The IDE controller is not usable on a Performa 6400 with 2.6.18:
> > 
> > <6>hda: Enabling MultiWord DMA 2
> > <4>ide0: Disabled unable to get IRQ 13.
> > <6>ide0: failed to initialize IDE interface
> 
>  .../...
> 
> Looks like a workaround for bogus OF bitrotted... What about this patch:

This patch work ok. Thanks.
