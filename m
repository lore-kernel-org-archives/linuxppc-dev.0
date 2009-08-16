Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E1115B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 16 Aug 2009 15:09:51 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 5A187DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2009 15:09:49 +1000 (EST)
Received: by ywh1 with SMTP id 1so3199183ywh.9
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 22:09:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1250374683.24143.69.camel@pasglop>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
	<3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
	<1250242149.24143.36.camel@pasglop>
	<Pine.LNX.4.64.0908141255230.5980@axis700.grange>
	<1250251664.24143.39.camel@pasglop>
	<20090815124347.GB16112@flint.arm.linux.org.uk>
	<1250374683.24143.69.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 15 Aug 2009 23:09:27 -0600
Message-ID: <fa686aa40908152209h7e1c384yfaa72c4e825e1df0@mail.gmail.com>
Subject: Re: ARM clock API to PowerPC
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 15, 2009 at 4:18 PM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> For ppc we really don't have much of a choice here anyway because we
> support multiple platforms compiled in the same kernel as long as they
> have a CPU core that's the same overall family, and that can be very
> wide. For example, 440-type cores can exist in all sort of IBM/AMCC
> cores, but also Xilinx FPGAs, and when you start saying FPGA the
> possibilities go wild :-)

Yes, exactly!  In fact, FPGAs are somewhat nicer in that only the
hardware actually needed is present on the running system (fewer data
instances), but the flip side is that the set of instances changes at
the whim of the FPGA engineer.  Static definition isn't an option
unless you want to change the platform source code for each new FPGA
bistream revision.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
