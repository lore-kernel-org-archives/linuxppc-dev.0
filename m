Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A49071A055C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 07:57:54 +1000 (EST)
Message-ID: <1402610228.14780.84.camel@pasglop>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 13 Jun 2014 07:57:08 +1000
In-Reply-To: <20140612122639.GA17838@gate.crashing.org>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
 <1402518131.14780.60.camel@pasglop>
 <20140611210351.GA7155@visitor2.iram.es>
 <20140612122639.GA17838@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2014-06-12 at 07:26 -0500, Segher Boessenkool wrote:
> But, indeed, it does look like GCC doesn't use it.  It seems to me
> that
> some ABI forbade userland (or non-libraries or whatever) from using
> it.
> I'll see what I can find out.

I can still use -ffixed-cr5 for safety no ?

Cheers,
Ben.
