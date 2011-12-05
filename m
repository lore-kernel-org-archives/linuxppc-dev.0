Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 6E4251007D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 17:02:00 +1100 (EST)
Date: Mon, 5 Dec 2011 08:03:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH-RFC 08/10] powerpc: switch to GENERIC_PCI_IOMAP
Message-ID: <20111205060337.GD22501@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <54aba7d0694e98b9103ca278486485598086b2be.1322163031.git.mst@redhat.com>
 <20111204104835.GJ15464@redhat.com>
 <1323031921.11728.25.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323031921.11728.25.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 05, 2011 at 07:52:01AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2011-12-04 at 12:48 +0200, Michael S. Tsirkin wrote:
> > On Thu, Nov 24, 2011 at 10:19:54PM +0200, Michael S. Tsirkin wrote:
> > > powerpc copied pci_iomap from generic code, probably to avoid
> > > pulling the rest of iomap.c in.  Since that's in
> > > a separate file now, we can reuse the common implementation.
> > > 
> > > The only difference is handling of nocache flag,
> > > that turns out to be done correctly by the
> > > generic code since arch/powerpc/include/asm/io.h
> > > defines ioremap_nocache same as ioremap.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > 
> > Sorry to nag, any ACKs/NACKs on the powerpc changes?
> > I intend to send this to Linus if there are no
> > objections. Thanks!
> 
> Ah sorry, forgot about that. Do you have a git tree I can pull to do
> quick test ?

Yes.

git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next 

Thanks!

> No objection in principle.
> 
> Cheers,
> Ben.
