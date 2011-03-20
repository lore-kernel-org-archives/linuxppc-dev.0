Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8234BB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 20:10:25 +1100 (EST)
Subject: Re: powerpc/pci sysdata batch hangs G5 boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikMbMqSRpt9gCrHgzpJuRCGL7rfLAs6erJL0Qjc@mail.gmail.com>
References: <alpine.LSU.2.00.1103192023140.1592@sister.anvils>
	<AANLkTikMbMqSRpt9gCrHgzpJuRCGL7rfLAs6erJL0Qjc@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 Mar 2011 20:10:10 +1100
Message-ID: <1300612210.2402.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Hugh Dickins <hughd@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-03-20 at 00:25 -0600, Grant Likely wrote:
> On Sat, Mar 19, 2011 at 9:41 PM, Hugh Dickins <hughd@google.com> wrote:
> > Hi Grant,
> >
> > I've been unable to boot mmotm on the G5 for a few weeks; and now that
> > the problem has reached Linus, I've bisected and it converges on your:
> >
> > commit b5d937de0367d26f65b9af1aef5f2c34c1939be0
> >    powerpc/pci: Make both ppc32 and ppc64 use sysdata for pci_controller
> 
> Hi Hugh,
> 
> Thanks for the testing.  I don't have access to a G5 unfortunately.
> Are you able to capture the good/bad console output and send it to me?
>  A digital photo would be fine if you can't grab the raw text.  Add
> #define DEBUG to the top of arch/powerpc/kernel/pci-common.c above the
> #includes too if you don't mind.
> 
> I'm investigating on my end.  I suspect that I've messed up retrieval
> of the hose pointer.

Hrm, you merged that already ? I would have liked to have a chance to at
least test and review properly...

Oh well, I have G5's here, I'll see if I can find what's wrong tomorrow.

Cheers,
Ben.
