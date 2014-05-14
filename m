Return-Path: <James.Yang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E0D7140087
 for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2014 04:19:35 +1000 (EST)
Date: Wed, 14 May 2014 13:04:46 -0500
From: James Yang <James.Yang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
In-Reply-To: <1398882547.24575.211.camel@snotra.buserror.net>
Message-ID: <alpine.LRH.2.00.1405141259380.17414@ra8135-ec1.am.freescale.net>
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
 <1391553822.6733.189.camel@snotra.buserror.net>
 <1398840308.5722.5.camel@concordia>
 <1398882547.24575.211.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2014, Scott Wood wrote:

> On Wed, 2014-04-30 at 16:45 +1000, Michael Ellerman wrote:
> > On Tue, 2014-02-04 at 16:43 -0600, Scott Wood wrote: 
> > > > +Motorola/Freescale 8xx
> > > > +----------------------
> > > > +
> > > > + - Software loaded with hardware assist.
> > > > + - All 32 bit
> > > > +
> > > > +   +--------------+
> > > > +   |     8xx      |
> > > > +   +--------------+
> > > > +          |
> > > > +          |
> > > > +          v
> > > > +   +--------------+
> > > > +   |     850      |
> > > > +   +--------------+
> > > 
> > > Is the core of MPC850 different from other MPC8xx?
> > 
> > Dunno, maybe someone who works at Freescale knows ;)
> 
> I think they're the same -- I was just wondering if you had some
> difference in mind that led you to single it out.


They are the same.  

There should not be a separate box that singles out 850.  (Still don't 
know why the diagram was drawn to single out 850 in the first place.)

The CPU core should be called "MPC8xx Core".  
