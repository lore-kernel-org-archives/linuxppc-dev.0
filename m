Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB22BDDE0C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 00:56:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2RDugx1025087
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 09:56:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2RDuddw090186
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:56:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2RDucaE000886
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:56:38 -0600
Date: Thu, 27 Mar 2008 08:53:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/2] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
Message-ID: <20080327085353.6ac04886@zod.rchland.ibm.com>
In-Reply-To: <47EBA616.9070705@ru.mvista.com>
References: <20080306134359.GA31762@ru.mvista.com>
	<1206400935.7197.59.camel@pasglop>
	<20080326073554.1d8229d6@zod.rchland.ibm.com>
	<47EBA616.9070705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Mar 2008 16:50:14 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Josh Boyer wrote:
> > On Tue, 25 Mar 2008 10:22:15 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> >> On Thu, 2008-03-06 at 16:43 +0300, Valentine Barshak wrote:
> >>> This patch adds ibm_newemac PHY clock workaround for 440EP/440GR EMAC
> >>> attached to a PHY which doesn't generate RX clock if there is no link.
> >>> The code is based on the previous ibm_emac driver stuff. The 440EP/440GR
> >>> allows controlling each EMAC clock separately as opposed to global clock
> >>> selection for 440GX.
> >>>
> >>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> >> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > This never went to netdev or Jeff from what I can see.
> > 
> > josh
> 
> Do I need to resend these and the other one from 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052114.html 
> cc'ing Jeff?

Can't hurt.

> I thought it was decided that Ben collects and sends all emac patches to 
> netdev.

So did I.

josh
