Return-Path: <bhelgaas@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8FBF1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 08:12:56 +1100 (AEDT)
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3F05214012C
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:12:55 +1100 (AEDT)
Received: by mail-ig0-f178.google.com with SMTP id a13so1755046igq.11
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 13:12:53 -0800 (PST)
Date: Tue, 11 Nov 2014 14:12:48 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
Message-ID: <20141111211248.GI28161@google.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop>
 <20141015221914.GD15225@google.com>
 <1413413732.11213.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413413732.11213.27.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Anton Blanchard <anton@au1.ibm.com>,
 Takashi Iwai <tiwai@suse.de>, Yijing Wang <wangyijing@huawei.com>,
 Brian King <brking@linux.vnet.ibm.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
> >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> > 
> > I'd be happy to merge it, but given what I know now, I would wait and merge
> > it during the v3.19 merge window.  It sounds like it's more urgent than
> > that and should be merged earlier, but from the changelogs, it looks like
> > we're just replacing the powerpc-specific quirk with a more generic one.
> > 
> > So I assume you'll merge it via powerpc unless I hear otherwise.
> 
> Either way works but it's easy to keep it all in one series in one tree.
> 
> The urgency is that the current powerpc quirk works only with one specific
> card (ie, one device ID for gfx and one for audio) and misses the DMA limitation
> of the sound driver (which is a somewhat orthogonal issue but the patch for it is
> in the series).
> 
> Any other radeon card causes the machine to crash at boot (the driver doesn't
> recover well from the EEH error triggered by the bad MSI address and the world
> falls over from there).
> 
> So I want this to go back into distros.

I'm still assuming you're going to merge this series, but I don't see it in
your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
yet.  Do you want me to do anything with it?

Bjorn
