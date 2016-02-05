Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434511A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 07:42:41 +1100 (AEDT)
Message-ID: <1454704951.2486.35.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Feb 2016 14:42:31 -0600
In-Reply-To: <CAPk1OjHnF=oi=M5son2vdsZwrhXC6Uy-wTJKpQiZcZMnWLb8KA@mail.gmail.com>
References: <CAPk1OjGew2n-17ztcbxcxBXWundeEk5nKQ5MS1HLYR4fiBOjxg@mail.gmail.com>
 <1453904726.27129.42.camel@buserror.net>
 <1453904822.27129.44.camel@buserror.net>
 <CAPk1OjGKxzCi58udCL2ocVOoiufetnfgJ1WUcjD-JbQs7Tbq9A@mail.gmail.com>
 <CAPk1OjHnF=oi=M5son2vdsZwrhXC6Uy-wTJKpQiZcZMnWLb8KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Question about 86xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-04 at 15:26 +0100, Alessio Igor Bogani wrote:
> Scott,
> 
> On 27 January 2016 at 15:41, Alessio Igor Bogani
> <alessio.bogani@elettra.eu> wrote:
> > Scott,
> > 
> > On 27 January 2016 at 15:27, Scott Wood <oss@buserror.net> wrote:
> > > On Wed, 2016-01-27 at 08:25 -0600, Scott Wood wrote:
> > > > On Wed, 2016-01-27 at 10:24 +0100, Alessio Igor Bogani wrote:
> > [...]
> > > > > I'm wondering if we are allowed to put together configurations of
> > > > > the
> > > > > 86xx base systems
> > [...]
> > > > > mpc86xx_defconfig/mpc86xx_smp_defconfig as like already done for
> > > > > 85xx
> > > > > ones.
> > > > Yes, that would be good.
> 
> There are 6 boards into arch/powerpc/configs/86xx directory. Five of
> them are based on dual core 8641 whereas one is based on single core
> 8610. How should I proceed? Use a single file (mpc86xx_defconfig) or
> use two files (mpc86xx_defconfig and mpc86xx_smp_defconfig)?

Use a fragment to enable SMP, like 85xx does.

-Scott
