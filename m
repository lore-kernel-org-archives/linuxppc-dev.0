Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FC371A0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 17:10:37 +1100 (AEDT)
Message-ID: <1415772636.10731.6.camel@concordia>
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
From: Michael Ellerman <mpe@ellerman.id.au>
To: minyard@acm.org
Date: Wed, 12 Nov 2014 17:10:36 +1100
In-Reply-To: <545B826F.7050501@acm.org>
References: <1415245107.292153.444216242273.0.gpush@pablo>
 <545B826F.7050501@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-06 at 08:15 -0600, Corey Minyard wrote:
> On 11/05/2014 09:38 PM, Jeremy Kerr wrote:
> > Corey & Michael: if this is acceptable, it may be mergable as two
> > separate patches - one for the IPMI subsystem, one for the powernv
> > platform.  However, we'd need to preserve their order: patch 2/2 depends
> > on 1/2, which provides the structure & function definitions. This'll
> > break the build if only 2/2 is in the tree, and CONFIG_IPMI_POWERNV is
> > set.
> >
> > Alternatively, they could be merged by one maintainer, pending an ack
> > from the other.
> 
> I'm fine either way.

How about the third option? :)

I've put patch 1 in a topic branch:

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/opal-ipmi

And will merge that into my next, probably by tomorrow.

If you merge the topic branch and then apply patch 2/2, then it should all go
in without any hiccups.

cheers
