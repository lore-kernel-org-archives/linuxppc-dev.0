Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9AAC3140099
 for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2014 04:29:14 +1000 (EST)
Message-ID: <1398882547.24575.211.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 30 Apr 2014 13:29:07 -0500
In-Reply-To: <1398840308.5722.5.camel@concordia>
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
 <1391553822.6733.189.camel@snotra.buserror.net>
 <1398840308.5722.5.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-30 at 16:45 +1000, Michael Ellerman wrote:
> On Tue, 2014-02-04 at 16:43 -0600, Scott Wood wrote: 
> > Missing e300 (603 derivative) and e600 (7448 derivative).
> 
> Happy to add them, where do they hang off?

e300 hangs off 603 and e600 hangs off 7448. :-)

> > > +Motorola/Freescale 8xx
> > > +----------------------
> > > +
> > > + - Software loaded with hardware assist.
> > > + - All 32 bit
> > > +
> > > +   +--------------+
> > > +   |     8xx      |
> > > +   +--------------+
> > > +          |
> > > +          |
> > > +          v
> > > +   +--------------+
> > > +   |     850      |
> > > +   +--------------+
> > 
> > Is the core of MPC850 different from other MPC8xx?
> 
> Dunno, maybe someone who works at Freescale knows ;)

I think they're the same -- I was just wondering if you had some
difference in mind that led you to single it out.

-Scott
