Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBF70DE027
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 05:15:34 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86JFViW011396
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 15:15:31 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86JFVtA655986
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 15:15:31 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86JFVnc031626
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 15:15:31 -0400
Date: Thu, 6 Sep 2007 14:15:05 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: finding out the processor frequency
Message-ID: <20070906141505.18bd399a@zod.rchland.ibm.com>
In-Reply-To: <20070906184308.GA22380@ld0162-tx32.am.freescale.net>
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
	<20070906184308.GA22380@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "Leisner, Martin" <Martin.Leisner@xerox.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 6 Sep 2007 13:43:08 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Thu, Sep 06, 2007 at 02:24:30PM -0400, Leisner, Martin wrote:
> > What exactly do we mean by "timebase"?
> > 
> > There a symbol in arch/powerpc/time.c:ppc_proc_freq which looks like the
> > processor frequency (derived from the dts).  But its not exported.
> > 
> > There's also ppc_tb_freq.
> 
> The timebase is the rate at which the timebase and decrementer registers
> tick.  It is not the same as the CPU core frequency.

Unless your timebase and decrementer clock source is tied to the CPU
clock. :)

So it depends on the board, and it can even depend on how the board is
initialized.  Some boards can change the timebase clock source on the
fly.

josh
