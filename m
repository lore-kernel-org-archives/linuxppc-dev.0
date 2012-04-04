Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 783DBB700F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2012 02:45:53 +1000 (EST)
Date: Wed, 4 Apr 2012 09:45:49 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: 3.4.0-rc1: No init found
In-Reply-To: <4F7C4058.6090405@in.ibm.com>
Message-ID: <alpine.DEB.2.01.1204040944210.4930@trent.utfs.org>
References: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
 <1333440522.3040.9.camel@pasglop>
 <alpine.DEB.2.01.1204030953320.4930@trent.utfs.org>
 <4F7C4058.6090405@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Apr 2012 at 18:06, Suzuki K. Poulose wrote:
> > INFO: Uncompressed kernel (size 0x6d4b80) overlaps the address of the
> > wrapper(0x400000)
> > INFO: Fixing the link_address of wrapper to (0x700000)
> >    Building modules, stage 2.
> >    MODPOST 24 modules
> > ------------
> > 
> > I started to see these messages in January (around Linux 3.2.0), but never
> > investigated what it was since the produced kernels continued to boot just
> > fine.
> 
> The above change was added by me. The message is printed when the 'wrapper'
> script finds that decompressed kernel overlaps the 'bootstrap code' which does
> the decompression. So it shifts the 'address' of the bootstrap code to the
> next higher MB. As such it is harmless.

OK, good to know that it's harmless. Thanks for the explanation.

Christian.
-- 
BOFH excuse #256:

You need to install an RTFM interface.
