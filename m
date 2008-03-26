Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8FE3DE212
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 23:38:34 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2QCcQ5x011070
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 08:38:26 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2QCcQXZ220118
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 08:38:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2QCcPwu008677
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 08:38:26 -0400
Date: Wed, 26 Mar 2008 07:35:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
Message-ID: <20080326073554.1d8229d6@zod.rchland.ibm.com>
In-Reply-To: <1206400935.7197.59.camel@pasglop>
References: <20080306134359.GA31762@ru.mvista.com>
	<1206400935.7197.59.camel@pasglop>
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

On Tue, 25 Mar 2008 10:22:15 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2008-03-06 at 16:43 +0300, Valentine Barshak wrote:
> > This patch adds ibm_newemac PHY clock workaround for 440EP/440GR EMAC
> > attached to a PHY which doesn't generate RX clock if there is no link.
> > The code is based on the previous ibm_emac driver stuff. The 440EP/440GR
> > allows controlling each EMAC clock separately as opposed to global clock
> > selection for 440GX.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This never went to netdev or Jeff from what I can see.

josh
