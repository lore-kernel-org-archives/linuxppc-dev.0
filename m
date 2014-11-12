Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 340821A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:23:40 +1100 (AEDT)
Message-ID: <1415759019.10731.1.camel@concordia>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Nov 2014 13:23:39 +1100
In-Reply-To: <20141111211248.GI28161@google.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
 <1413413732.11213.27.camel@pasglop> <20141111211248.GI28161@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Brian King <brking@linux.vnet.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 Takashi Iwai <tiwai@suse.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-11 at 14:12 -0700, Bjorn Helgaas wrote:
> On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
> > >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> 
> I'm still assuming you're going to merge this series, but I don't see it in
> your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
> yet.  Do you want me to do anything with it?

I'm doing the powerpc tree this cycle, so it'd be in my tree, but it's not:

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/

Ben if you want me to take it let me know.

cheers
