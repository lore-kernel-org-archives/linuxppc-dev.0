Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 958CC1A0C0C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 11:25:09 +1100 (AEDT)
Message-ID: <1422923108.4625.2.camel@ellerman.id.au>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for
 !CONFIG_OF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 03 Feb 2015 11:25:08 +1100
In-Reply-To: <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-2-git-send-email-haokexin@gmail.com>
 <1422844101.11325.4.camel@ellerman.id.au>
 <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kevin Hao <haokexin@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-02 at 09:47 -0600, Bjorn Helgaas wrote:
> On Sun, Feb 1, 2015 at 8:28 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> >> So we can avoid the ugly #ifdef in some drivers.
> >>
> >> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> >> ---
> >>  include/linux/pci.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> >
> > Hi Bjorn,
> >
> > Do you mind putting this into your next for 3.20? Or giving us an ACK for it if
> > you prefer.
> 
> I think it makes more sense to merge this along with the other 14
> patches that remove the #ifdefs (at least, I assume that's what they
> do; I haven't seen them).

Yeah that is what they do.

The problem with doing it that way is the rest of the patches are splattered
all across the tree, so getting them merged as a series will require a lot of
searching for acks.

If you merged this one for 3.20 we could then merge the rest of the series one
at a time as the respective maintainers get around to it during the 3.21 cycle.

I probably should have said all that in my original mail :)

Anyway it's not a big deal, but that's why it'd be nice if you could take it.

cheers
