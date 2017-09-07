Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpFNY4nYBzDrYn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 08:23:57 +1000 (AEST)
Message-ID: <1504823028.12628.39.camel@kernel.crashing.org>
Subject: Re: UIO memmap of PCi devices not working?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 08 Sep 2017 08:23:48 +1000
In-Reply-To: <1504779569.31322.16.camel@infinera.com>
References: <1504711235.27247.110.camel@infinera.com>
 <1504768612.12628.19.camel@kernel.crashing.org>
 <1504768943.27247.149.camel@infinera.com>
 <1504773212.12628.26.camel@kernel.crashing.org>
 <1504774792.31322.13.camel@infinera.com>
 <1504779569.31322.16.camel@infinera.com>
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

On Thu, 2017-09-07 at 10:19 +0000, Joakim Tjernlund wrote:
> > Problem is that pci_mem_offset is gone, the closed I can find is mem_offset
> > but that is an array,maybe just mem_offset[0] ?
> > 
> > > I'm not sure exactly what's going
> > > on in your case, if you have a problem can you add printk to instrument
> > > ?
> > 
> > Seems to be something else going on in out board. Anyhow, the mem_offset should
> > be fixed to compile, nice to have it behind a CONFIG option. Then
> > one can start the process to remove the special casing easier.
> 
> After sorting the bugs in our app, it works with and without above patch.

Ok. I don't see a pressing need to change what we are doing in the
kernel then.

Cheers,
Ben.
