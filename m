Return-Path: <ntl@pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id 3DCDBDDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 12:55:23 +1100 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id E83CF45E61D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 20:24:50 -0500 (EST)
Date: Fri, 14 Dec 2007 19:23:21 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH v3 4/4] Freescale enhanced Local Bus Controller FCM NAND
	support.
Message-ID: <20071215012321.GJ28696@localdomain>
References: <20071214221736.GA21231@loki.buserror.net>
	<20071214190819.29cbe0bb@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214190819.29cbe0bb@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 14 Dec 2007 16:17:36 -0600
> Scott Wood <scottwood@freescale.com> wrote:
>
> > +	child = NULL;
> > +	while ((child = of_get_next_child(ofdev->node, child)))
> > +		if (of_device_is_compatible(child, "fsl,elbc-fcm-nand"))
> > +			fsl_elbc_chip_probe(ctrl, child);
> 
> Don't you need some of_node_put calls here?

The of_... iterators do of_node_put() for you as long as you don't
break out of the loop early.
