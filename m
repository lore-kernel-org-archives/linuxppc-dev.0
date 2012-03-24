Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 60D2FB6EE7
 for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2012 10:53:52 +1100 (EST)
Message-ID: <1332633218.2882.16.camel@pasglop>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Date: Sun, 25 Mar 2012 10:53:38 +1100
In-Reply-To: <20120321162549.8C1D0202A4D@gemini.denx.de>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-21 at 17:25 +0100, Wolfgang Denk wrote:
> > > The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes
> with the
> > > ELDK 4.2) this assembly instruction is not known and the build
> breaks.
> > 
> > Sigh.  GCC 4.2 is pretty old at this point.
> 
> But still rock-solid ...  We use it a lot, especially as reference for
> more recent (and sometimes more broken) versions of GCC.

Isn't this a binutils rather than gcc issue ?

Cheers,
Ben.
