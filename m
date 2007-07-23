Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id D3BABDDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 01:22:19 +1000 (EST)
Date: Mon, 23 Jul 2007 08:24:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Someone broke my allmodconfig build
Message-ID: <20070723152458.GB29187@mag.az.mvista.com>
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
	<20070722020412.GQ3925@crusty.rchland.ibm.com>
	<20070723014337.GC3272@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070723014337.GC3272@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2007 at 11:43:37AM +1000, David Gibson wrote:
> On Sat, Jul 21, 2007 at 09:04:13PM -0500, Josh Boyer wrote:
> > On Sun, Jul 22, 2007 at 10:37:06AM +1000, Paul Mackerras wrote:
> > > Stephen Rothwell writes:
> > > 
> > > >   WRAP    arch/powerpc/boot/zImage.ps3
> > > > /home/sfr/kernels/linus/arch/powerpc/boot/wrapper: line 113: dtc: command not found
> > > > make[2]: *** [arch/powerpc/boot/zImage.ps3] Error 1
> > > 
> > > Hmmm, we should be shipping .dtb files with the tree, so people don't
> > > have to have dtc installed.
> > 
> > Really?  I don't think we're quite ready for that.  Particularly for the
> > embedded boards.  Those DTS files still get lots of churn, and having to
> > update both the .dts and .dtb at the same time seems a bit fragile.
> 
> I sort of prefer this option in theory, but it's basically
> impossible.  People updating dts files by patch would also have to
> update the dtb, which can't be done in a normal patch, since they're
> binary.

I agree.  Shipping a magic binary blob, especially ones that haven't
really settled out, will be a real headache for poeple.

> I'm working with sfr now on importing dtc into the kernel tree.

IIRC, this was discussed when dtc first came into existence but it was
pooh-poohed.  I forget why now.

Mark
