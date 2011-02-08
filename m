Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2900CB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 01:29:39 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p18E3SnC009720
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Feb 2011 09:04:22 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E9CF04DE8042
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 09:28:43 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p18ETU0h470878
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Feb 2011 09:29:30 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p18ETUDu031447
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Feb 2011 07:29:30 -0700
Subject: Re: [PATCH v2 3/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1297115180.14982.83.camel@pasglop>
References: <1294267483.24377.30.camel@flin.austin.ibm.com>
	<1297055437.14982.57.camel@pasglop>
	<1297114832.24377.42.camel@flin.austin.ibm.com>
	<1297115180.14982.83.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Feb 2011 08:29:26 -0600
Message-ID: <1297175367.24377.44.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-02-08 at 08:46 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 15:40 -0600, Tseng-Hui (Frank) Lin wrote:
> > > We are -really- re-inventing interrupts and/or notifiers here, which
> > > I find a tad annoying..
> > 
> > Agree. This is ugly. We could have just used the regular interrupt
> > mechanism if the firmware didn't use shared rtas call and interrupt
> > to report multiple types of events.
> 
> A notifier wouldn't have worked ?

Yes. A notifier should have worked. Will change to use a notifier for
the chain.

> 
> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
