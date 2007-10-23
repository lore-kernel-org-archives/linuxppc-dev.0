Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 433A5DDF9D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:50:57 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NFortH024199
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 11:50:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NFoqid095690
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:50:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NFopPS020888
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:50:51 -0600
Date: Tue, 23 Oct 2007 10:50:38 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
Message-ID: <20071023105038.3f03d7d8@weaponx.rchland.ibm.com>
In-Reply-To: <471E14AD.9090306@ru.mvista.com>
References: <20071008142658.GA15197@ru.mvista.com>
	<20071023103316.471f8afa@weaponx.rchland.ibm.com>
	<471E14AD.9090306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 23 Oct 2007 19:35:09 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Josh Boyer wrote:
> > On Mon, 8 Oct 2007 18:26:58 +0400
> > Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> > 
> >> PowerPC 440EPx Sequoia USB OHCI device tree entry.
> >>
> >> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > 
> > I think I saw the OHCI big endian quirk patch go into Linus' tree
> > recently.  Is that the only patch this one depends on?
> > 
> 
> Yes, now we only need a dts entry to enable ohci support for 440EP(x),
> Valentine.

Ok.  I'll queue up this patch in a bit.  Thanks.

josh
