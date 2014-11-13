Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27D691A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 16:19:29 +1100 (AEDT)
Message-ID: <1415855968.28703.5.camel@concordia>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Nov 2014 16:19:28 +1100
In-Reply-To: <1415765215.5124.30.camel@kernel.crashing.org>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
 <1413413732.11213.27.camel@pasglop> <20141111211248.GI28161@google.com>
 <1415759019.10731.1.camel@concordia>
 <1415765215.5124.30.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Dave Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>,
 Brian King <brking@linux.vnet.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev@ozlabs.org, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-12 at 15:06 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2014-11-12 at 13:23 +1100, Michael Ellerman wrote:
> > On Tue, 2014-11-11 at 14:12 -0700, Bjorn Helgaas wrote:
> > > On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
> > > > >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> > > 
> > > I'm still assuming you're going to merge this series, but I don't see it in
> > > your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
> > > yet.  Do you want me to do anything with it?
> > 
> > I'm doing the powerpc tree this cycle, so it'd be in my tree, but it's not:
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/
> > 
> > Ben if you want me to take it let me know.
> 
> Hrm, I might have dropped the ball accidentally here. Bjorn did you
> actually Ack the core changes ? In that case we should probably pick it
> up.

I tried piecing together this series with v2 of patch 3 as you described, I
think, but it didn't apply cleanly, and I'm not confident I won't screw it up.

So please resend the series the way you want it to go in.

You got an ack from Bjorn:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

And he asked you change the subject on patch 2 to:

  PCI/MSI: Add device flag indicating that 64-bit MSIs don't work


cheers
