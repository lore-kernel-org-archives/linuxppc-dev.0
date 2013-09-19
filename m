Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by ozlabs.org (Postfix) with ESMTP id 7ABF92C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 10:17:40 +1000 (EST)
Date: Thu, 19 Sep 2013 14:00:37 -0700
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Preliminary kexec support for Linux/m68k
Message-ID: <20130919210037.GG2918@verge.net.au>
References: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdW8y9_=LXQ1PXjFaPyq-nYTPe+FodE5hQh4P3QSdnP_dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdW8y9_=LXQ1PXjFaPyq-nYTPe+FodE5hQh4P3QSdnP_dg@mail.gmail.com>
Cc: kexec@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Anton Blanchard <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 19, 2013 at 11:20:22AM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 17, 2013 at 12:01 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > This is a preliminary set of patches to add kexec support for m68k.
> 
> >   - [PATCH 1/3] m68k: Add preliminary kexec support
> >   - [PATCH 2/3] m68k: Add support to export bootinfo in procfs
> >   - [PATCH 3/3] [RFC] m68k: Add System RAM to /proc/iomem
> >
> > Notes:
> >   - The bootinfo is now saved and exported to /proc/bootinfo, so kexec-tools
> >     can read it and pass it (possibly after modification) to the new kernel.
> >     This is similar to /proc/atags on ARM.
> 
> >   - I based [PATCH 3/3] on the PowerPC version, but it's no longer needed as we
> >     now get this information from the bootinfo.
> >     Does anyone think this is nice to have anyway?
> 
> It seems kexec/kdump on ppc don't use /proc/iomem anymore, and only rely on
> /proc/device-tree these days?

I think thats entirely a matter for the m68k kernel maintainers to decide.
But my personal opinion is that it is nice not to add it if it isn't needed.
