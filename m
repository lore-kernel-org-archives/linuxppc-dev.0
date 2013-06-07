Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F4AA2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 13:52:33 +1000 (EST)
Message-ID: <1370577138.3766.342.camel@pasglop>
Subject: Re: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@tabi.org>
Date: Fri, 07 Jun 2013 13:52:18 +1000
In-Reply-To: <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-16 at 09:56 -0500, Timur Tabi wrote:
> On Thu, May 16, 2013 at 1:52 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >> 3) run " pix altbak" command
> >>
> >> 4) check you are on bank4
> >
> > It stays on bank 0
> 
> pix altbank

So I got the rev2 chip today, put it in, and PCI-E is still not getting
a link. Since the LEDs of the e1000 aren't coming up at all, I *suspect*
the slots are getting no power.

Is there a power control somewhere ? Maybe some DIP or jumpers that
might have gone off ?

Cheers,
Ben.
