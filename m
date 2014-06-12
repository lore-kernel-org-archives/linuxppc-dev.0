Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F41121A055E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 08:15:46 +1000 (EST)
Date: Thu, 12 Jun 2014 17:15:13 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
Message-ID: <20140612221513.GB28378@gate.crashing.org>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
 <1402518131.14780.60.camel@pasglop> <20140611210351.GA7155@visitor2.iram.es>
 <20140612122639.GA17838@gate.crashing.org>
 <1402610228.14780.84.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402610228.14780.84.camel@pasglop>
Cc: Tejun Heo <htejun@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@gentwo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 13, 2014 at 07:57:08AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2014-06-12 at 07:26 -0500, Segher Boessenkool wrote:
> > But, indeed, it does look like GCC doesn't use it.  It seems to me
> > that
> > some ABI forbade userland (or non-libraries or whatever) from using
> > it.
> > I'll see what I can find out.
> 
> I can still use -ffixed-cr5 for safety no ?

Yes, definitely, and in fact you have to if GCC changes to not have cr5
fixed by default (which may or may not happen).  It will be good
documentation in either case :-)


Segher
