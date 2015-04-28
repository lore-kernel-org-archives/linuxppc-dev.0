Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D2101A031C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:59:26 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 00:59:24 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 12EDD38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 02:59:22 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S6xMBi53805076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 06:59:22 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S6xKW5011746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 02:59:20 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jacek Anaszewski <j.anaszewski81@gmail.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
In-Reply-To: <20150424121629.69a159b3@ja.home>
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
 <m3egnama5l.fsf@oc8180480414.ibm.com> <20150424121629.69a159b3@ja.home>
Date: Tue, 28 Apr 2015 16:59:18 +1000
Message-ID: <m3zj5slovt.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, cooloney@gmail.com, rpurdie@rpsys.net,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jacek Anaszewski <j.anaszewski81@gmail.com> writes:
> Is the DT node we are discussing used by some other drivers than the
> LED class driver? Or is it required in this form by other components of
> your platform?

OS kernels are the chief consumers, Linux being the overwhelmingly major
one here.

But this is what firmware currently produces.

Changing the DT representation at this stage is perhaps *possible*
without creating a bunch of pain (I'd have to audit a bunch of things to
see if we have GA shipping systems with this functionality for instance,
and then evaluate the impact to partners and our various labs) which is
a lot of work I don't particularly want to do and is well below urgent
item 248 on my TODO list, especially for what seems to be largely a
cosmetic suggestion?

That being said, more and better review of things we're putting in the
device tree in firmware is probably a good thing. After all, once we
release we do kind of have to live with it essentially forever. If
people are able to aid in that kind of code review, I'd be most welcome
to hear it.
