Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id C73C6DE09D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 11:44:01 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2465049pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 18:43:59 -0700 (PDT)
Subject: Re: Get new_emac driver running on 405EP
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Markus Brunner <super.firetwister@googlemail.com>
In-Reply-To: <200804152351.42651.super.firetwister@gmail.com>
References: <6a6049b80804141038k77ac361cl11f50bc9d890c6a2@mail.gmail.com>
	<1208206961.6958.180.camel@pasglop>
	<200804152351.42651.super.firetwister@gmail.com>
Content-Type: text/plain
Date: Tue, 15 Apr 2008 20:43:54 -0500
Message-Id: <1208310234.5869.59.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-04-15 at 23:51 +0200, Markus Brunner wrote:
> On Monday 14 April 2008, Benjamin Herrenschmidt wrote:
> > > 2) On the 405EP only the MDIO pin of the emac0 is pinned out, so both
> > > phys have to be accessed through this one. This affectes the mdio
> > > read/write functions.
> >
> > The later can easily be described in the device-tree as it's a fairly
> > common setup.
> 
> mdio-device does the trick. This feature wasn't used by any other board in the 
> kernel yet.
> 
> I made another error. I did mix up the order of the MAL irqs, so the irq 
> handlers went mad. This was detected as a soft lock-up.
> 
> After correcting that both emacs are working on ppc405EP :).

Cool.  Btw, new board ports are welcome :).

josh
