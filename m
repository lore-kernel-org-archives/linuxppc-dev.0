Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B00331A0744
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 20:33:05 +1100 (AEDT)
Message-ID: <1427880773.20500.170.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reword the "returning from prom_init" message
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 01 Apr 2015 20:32:53 +1100
In-Reply-To: <551B96B8.3050708@ozlabs.org>
References: <1427697489-30249-1-git-send-email-mpe@ellerman.id.au>
 <551B96B8.3050708@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: pc@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-01 at 14:56 +0800, Jeremy Kerr wrote:
> Hi Michael,
> 
> > Let's try something different.
> > 
> > This prints:
> > 
> >   Quiescing Open Firmware ...
> >   Booting Linux via __start() ...
> 
> "returning from prom_init" has been an emblem of the powerpc kernel boot
> since old times. I feel like we should give the old message a Viking
> funeral and pick a date for a minute of silence.

Let's drink to that :-)

> (Wistfully-)Acked-by: Jeremy Kerr <jk@ozlabs.org>
> 
> Cheers,
> 
> 
> Jeremy
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
