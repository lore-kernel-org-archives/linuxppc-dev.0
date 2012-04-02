Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 25576B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 07:11:19 +1000 (EST)
Message-ID: <1333401070.30734.55.camel@pasglop>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 03 Apr 2012 07:11:10 +1000
In-Reply-To: <m2r4w6jugo.fsf@linux-m68k.org>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <1333340517.30734.42.camel@pasglop>
 <m2r4w6jugo.fsf@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-02 at 12:31 +0200, Andreas Schwab wrote:
> >  - PowerMac7,3 aka Dual G5 AGP. This ones has U3 + K2 and
> > uses cascaded MPICs
> 
> That's the same as mine, config is attached.  I'm currently trying to
> bisect the commit that actually broke the series. 

Hrm, odd.. I'll dbl check today that I didn't b0rk something in my test
(like loading the wrong kernel :-) I'll also try with your config.

Cheers,
Ben.
