Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 142501A028C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 10:37:14 +1100 (AEDT)
Message-ID: <1452814633.19265.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Date: Fri, 15 Jan 2016 10:37:13 +1100
In-Reply-To: <5697FE17.4070605@linux.vnet.ibm.com>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1452681487.7404.6.camel@ellerman.id.au>
 <56963E40.8070702@linux.vnet.ibm.com>
 <1452720339.8203.4.camel@ellerman.id.au>
 <5697FE17.4070605@linux.vnet.ibm.com>
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

On Thu, 2016-01-14 at 17:59 -0200, Guilherme G. Piccoli wrote:
> On 01/13/2016 07:25 PM, Michael Ellerman wrote:

> > But for example what happens if the user boots with eeh=off on the command
> > line, and then hotplugs a device. It looks like because you're not using
> > eeh_enabled() you will incorrectly initialise EEH anyway?
>
> Thanks very much for this catch Michael! I didn't think in this
> possibility; I just tested and it fails with the kernel oops.

OK, that's a pity.

> So, since my patch does not cover this case, I think would be more
> interesting "unlink" the DDW mechanism from the EEH. It seems easy, I'll
> try to send you a patch soon.
>
> Do you think it is a good approach?

It sounds good, but I don't know off hand whether it will work. See how it goes
and send us the patch.

cheers
