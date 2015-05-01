Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 687E21A0D10
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 13:51:37 +1000 (AEST)
Message-ID: <1430452297.11970.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Delay probing EEH device during hotplug
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 01 May 2015 13:51:37 +1000
In-Reply-To: <20150501012840.GA12990@gwshan>
References: <1430436135-15721-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430437857.32679.2.camel@ellerman.id.au> <20150501012840.GA12990@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-05-01 at 11:28 +1000, Gavin Shan wrote:
> On Fri, May 01, 2015 at 09:50:57AM +1000, Michael Ellerman wrote:
> >On Fri, 2015-05-01 at 09:22 +1000, Gavin Shan wrote:
> >> Commit 1c509148b ("powerpc/eeh: Do probe on pci_dn") probes EEH
> >> devices in early stage, which is reasonable to pSeries platform.
> >> However, it's wrong for PowerNV platform because the PE# isn't
> >> determined until the resources (IO and MMIO) are assigned to
> >> PE in hotplug case. So we have to delay probing EEH devices
> >> for PowerNV platform until the PE# is assigned.
> >> 
> >> Fixes: 1c509148b ("powerpc/eeh: Do probe on pci_dn")
> >
> >I don't have that SHA.
> >
> >I've have a commit with the same subject which is ff57b454ddb9.
> >
> >Is that the same thing?
> 
> Yes, they're same thing.

OK.

> There seems something wrong at local because "git show 1c509148b" leads
> me to the patch as well. However, I believe ff57b454ddb9 is the correct
> one. I'll send v2 to fix it up.

You just have it in your tree from when you were developing it I guess?

If you do:

  $ git show --format=fuller 1c509148b

It should show you the committer etc.

cheers
