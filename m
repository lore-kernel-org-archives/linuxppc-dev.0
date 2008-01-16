Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5CFCDDE35
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 02:03:06 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0GF2vvd020419
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 10:02:57 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0GF2kRV1097782
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 10:02:47 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0GF2iwF003364
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 08:02:45 -0700
Date: Wed, 16 Jan 2008 09:01:10 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
Message-ID: <20080116090110.1b7b2f00@zod.rchland.ibm.com>
In-Reply-To: <1200477239.6755.21.camel@pasglop>
References: <1200476230-14026-1-git-send-email-sr@denx.de>
	<1200477239.6755.21.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Jan 2008 20:53:59 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-01-16 at 10:37 +0100, Stefan Roese wrote:
> > With the removal the the "rgmii-interface" device_type property from the
> > dts files, the newemac driver needs an update to only rely on compatible
> > property.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> 
> I need to test if it works on CAB, can't change the DT on those. I'll
> let you know tomorrow.

This should be fine on CAB.  The rgmii node has:

compatible = "ibm,rgmii-axon", "ibm,rgmii"

so the match should still catch on the latter.

josh
