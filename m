Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg6mv5CqVzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:00:31 +1000 (AEST)
Message-ID: <1467262824.7296.3.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix NULL pointer dereference on kernel contexts
 with no AFU interrupts
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Ian Munsie
 <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,  Frederic Barrat
 <frederic.barrat@fr.ibm.com>, Huy Nguyen <huyn@mellanox.com>
Date: Thu, 30 Jun 2016 15:00:24 +1000
In-Reply-To: <ac33c4a3-544f-2917-1cd7-14c62f176522@au1.ibm.com>
References: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
 <ac33c4a3-544f-2917-1cd7-14c62f176522@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-30 at 08:28 +1000, Andrew Donnellan wrote:
> On 30/06/16 04:55, Ian Munsie wrote:
> > 
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > If a kernel context is initialised and does not have any AFU interrupts
> > allocated it will cause a NULL pointer dereference when the context is
> > detached since the irq_names list will not have been initialised.
> > 
> > Move the initialisation of the irq_names list into the cxl_context_init
> > routine so that it will be valid for the entire lifetime of the context
> > and will not cause a NULL pointer dereference.
> > 
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

> As it's nice having your machine not crash on every shutdown...

Fixes: ????

cheers
