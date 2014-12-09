Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B07471A017B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 10:56:45 +1100 (AEDT)
Message-ID: <1418169405.30244.1.camel@concordia>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 10 Dec 2014 10:56:45 +1100
In-Reply-To: <1418159084.5581.32.camel@freescale.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <1417805565.334.15.camel@freescale.com> <1418098262.527.1.camel@concordia>
 <1418159084.5581.32.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <gkurz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 15:04 -0600, Scott Wood wrote:
> On Tue, 2014-12-09 at 15:11 +1100, Michael Ellerman wrote:
> > On Fri, 2014-12-05 at 12:52 -0600, Scott Wood wrote:
> > > On Fri, 2014-12-05 at 16:14 +0100, Greg Kurz wrote:
> > > > The smt-enabled kernel parameter basically leaves unwanted cpus executing
> > > > in firmware or wherever they happen to be. The very same applies to the
> > > > ibm,smt-enabled DT property which is no more used by anything known. These
> > > > are hacks that shoudn't be used in a production environment.
> > > > 
> > > > Quoting mpe, "there are better ways for firmware to disable SMT".
> > > 
> > > Those "better ways" don't apply to Freescale chips, where the OS enables
> > > (or not) SMT without any interaction with firmware.
> > 
> > But how does it know there even are SMT threads? From the device tree? So
> > just don't present the threads in the device tree?
> 
> The device tree is for hardware description, not configuration...

Oh please, you're quoting device tree scripture to me now?

cheers
