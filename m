Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0081A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 07:31:22 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6543F14021A
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2015 07:31:20 +1000 (AEST)
Message-ID: <1428442269.22867.467.camel@freescale.com>
Subject: Re: [PATCH 0/8] powerpc/8xx: Getting rid of CONFIG_8xx
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Tue, 7 Apr 2015 16:31:09 -0500
In-Reply-To: <5523932C.8070303@c-s.fr>
References: <20150312152420.11C821A2425@localhost.localdomain>
 <1426203271.2772.3.camel@ellerman.id.au>
 <1427244330.22867.76.camel@freescale.com> <5523932C.8070303@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 10:19 +0200, leroy christophe wrote:
> Le 25/03/2015 01:45, Scott Wood a écrit :
> > On Fri, 2015-03-13 at 10:34 +1100, Michael Ellerman wrote:
> >> You'll need to collect ACKs, or get the individual patches merged, and then we
> >> can take patch 8 through the powerpc tree once those are all in - probably for
> >> 4.2.
> > It looks like CONFIG_8xx is used a lot more than CONFIG_PPC_8xx, so it
> > would be less churn to get rid of the latter (plus, we also have
> > CONFIG_4xx, CONFIG_6xx, etc).  The only use of PPC_8xx I see outside
> > arch/powerpc is in drivers/watchdog/Kconfig.
> 
> Ok, we can do that. But when outside of arch/powerpc/, isn't is more 
> explicit with CONFIG_PPC_8xx rather that CONFIG_8xx ?

Yes, CONFIG_PPC_8xx is a better name, but churn and consistency matter
as well.

> Now that I have submitted the first set of patch, don't we have a risk 
> that now it is already merged by some other maintainers ?

Sigh.  I see a couple in linux-next.

-Scott
