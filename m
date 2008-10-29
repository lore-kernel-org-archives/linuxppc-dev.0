Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E628FDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 04:10:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9THAYTr001862
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 13:10:34 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9THAYtB084582
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 13:10:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9THARbi029644
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 13:10:27 -0400
Date: Wed, 29 Oct 2008 13:10:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jhsiao@amcc.com
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v2]
Message-ID: <20081029131032.07a3be35@zod.rchland.ibm.com>
In-Reply-To: <1225299899.4841.7.camel@jhsiao-usb>
References: <1225237276.1850.13.camel@jhsiao-usb>
	<20081028205132.255e674d@zod.rchland.ibm.com>
	<1225246700.1850.61.camel@jhsiao-usb>
	<20081029105413.895d5cdb.kim.phillips@freescale.com>
	<1225299899.4841.7.camel@jhsiao-usb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Oct 2008 10:04:59 -0700
James Hsiao <jhsiao@amcc.com> wrote:
> > > > - Complete lack of locking code, how do you enforce mutually exclusive
> > > > access to the device?
> > > 
> > > The crypto engine have couple bits 'command ready' and 'packet done',
> > > which servers as semaphore here. So, software don't need extra locking.
> > 
> > know if it's applicable at all, but I imagine it's not SMP safe.
> 
> No, it's not SMP safe. This driver only support single core processors.

What about preemption?  You do not have to be a multi-core CPU to have
SMP-like problems.

josh
