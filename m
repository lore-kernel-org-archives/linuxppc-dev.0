Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBEC1A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 15:11:03 +1100 (AEDT)
Message-ID: <1418098262.527.1.camel@concordia>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 09 Dec 2014 15:11:02 +1100
In-Reply-To: <1417805565.334.15.camel@freescale.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <1417805565.334.15.camel@freescale.com>
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

On Fri, 2014-12-05 at 12:52 -0600, Scott Wood wrote:
> On Fri, 2014-12-05 at 16:14 +0100, Greg Kurz wrote:
> > The smt-enabled kernel parameter basically leaves unwanted cpus executing
> > in firmware or wherever they happen to be. The very same applies to the
> > ibm,smt-enabled DT property which is no more used by anything known. These
> > are hacks that shoudn't be used in a production environment.
> > 
> > Quoting mpe, "there are better ways for firmware to disable SMT".
> 
> Those "better ways" don't apply to Freescale chips, where the OS enables
> (or not) SMT without any interaction with firmware.

But how does it know there even are SMT threads? From the device tree? So
just don't present the threads in the device tree?

cheers
