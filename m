Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 28008DDD07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 22:38:32 +1100 (EST)
Date: Tue, 20 Feb 2007 13:35:23 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Lorenz Kolb <linuxppcemb@lkmail.de>
Subject: Re: What is the difference between Montavista Kernel Source,	and
	Kernel.Org Source
Message-ID: <20070220133523.5e69f7f4@vitb.dev.rtsoft.ru>
In-Reply-To: <45D8286B.4030900@lkmail.de>
References: <mailman.1.1171760401.17466.linuxppc-embedded@ozlabs.org>
	<45D8286B.4030900@lkmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 18 Feb 2007 11:20:27 +0100
Lorenz Kolb <linuxppcemb@lkmail.de> wrote:

> 
> >> I'm Going to use linux on ML403.
> >>
> >> I want to know, what is the difference between the linux kernel source,
> >> that we download from source.mvista.com ( using git ) and the original
> >> kernel source code that we download from kernel.org?
> >>     
Being brief, some Mvista patches were not merged due to various reasons 
(such as say Xilinx stuff for a while) and anyone interested can still use
that work. So for instance people asking here and in other ML's can be just referred 
to those git trees and obtain a full understanding what were done to get things work.

> >
> > The multiple git trees hosted at source.mvista.com/git are development
> > trees similar to the trees hosted at www.kernel.org/git.  Contact the
> > individual developers for details on each tree.
> >
> > Dale Farnsworth
> >
> >   
> Oh, and I thought that development does mean something like progress.
> If I'd "develop" something "new" with last change 8 months ago, I guess 
> my boss would not pay for that "development".
> 
sorry, but that is not quite right. Trees there are development stuff for 4.x MVL
product (at least ppc-related), and now active development is heading for next release.

I don't think you'll find these up-to-date sources in source.mvista.com, bit not because
of internal reasons - almost all the efforts were brought up to the community and merged 
to the stock kernel tree. 

> So what is the difference between kernel.org and montavista's tree for 
> ML403.
> 
> kernel.org is quite a bit ahead.
> 
> Personally I'd recommend Denk's 2.6.19 tree (that's a 2.6.19 from 
> kernel.org with some ppc specific patches, afaik) and patching the EDK 
> 8.2 into it. That's quite a lot of work (I am just doing that at the 
> moment) but that's the only way to get an up-to-date system.
> Currently my partner and I are working on building a minimalistic sound 
> driver and in some future release a ALSA compliant sound driver and a 
> new controller (with at least DMA support) as this is can still not be 
> found in MontaVista.
> 
Xilinx stuff is a really interesting approach. Sorry,  but I guess "patching the EDK 
8.2 into it" is not the thing maintainers are expecting to appear upstream. So, referred mvista code can 
be used as a reference, but a living solution requires careful consideration. Do some investigations,
share the thoughts and you'll not be left alone.

As a side note, most of the active work is in the mainstream kernel, MV, Denx and many others actively 
participating in it.

-- 
Sincerely, 
Vitaly
