Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound3-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3EAD7DDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 15:07:54 +1000 (EST)
Date: Mon, 13 Aug 2007 22:07:45 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Best Linux tree for Xilinx support.
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com><fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
	<406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

I am in the process of publishing a Xilinx Linux git tree which will
contain most of the drivers for Xilinx IP including recent contributions
from Grant Likely, John Williams, Joachim Foerster and others.

This tree will be available on the Xilinx git server soon, however it
will be a non-supported (and likely unstable) tree. Its main purpose is
to provide a common code base for development and a channel to push new
driver code out into the community.

I am still waiting on IT to set up the new server machine. I will post
an announcement once the server is up and running.

Cheers,
   Wolfgang

Leonid wrote:
> Hi:
> 
> I have several boards with different architectures (Microblaze, PPC),
> running Linux/uClinux and using Xilinx IP cores. I use both Virtex and
> Spartan FPGAs.
> 
> Historically I'm using different kernels for them, starting from uClinux
> 2.4, all way through Linux 2.6.16 and 2.6.19. I patched them here and
> there to get working.
> 
> I certainly feel a need to move to some standard kernel tree.
> 
> I understand that you guys are in some advanced steps of integrating
> Xilinx into Linux. What would be my best choice of Linux kernel now?
> 
> I see the following options:
> 
> - download some GIT tree your are using (which one?).
> - get latest tree from kernel.org and patch it using your patches (where
> I can get them?).
> - ??
> 
> Please advise,
> 
> Thanks,
> 
> Leonid.
> 
