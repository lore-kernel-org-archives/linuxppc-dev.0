Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id D7D63DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 08:26:52 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so324081anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 15:26:51 -0700 (PDT)
Message-ID: <fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com>
Date: Fri, 16 May 2008 16:26:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
Subject: Re: arch/powerpc, Xilinx, and mainline kernel support
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 4:06 PM, Koss, Mike (Mission Systems)
<mike.koss@ngc.com> wrote:
> Is there any reason why the mainline 2.6.25.3 (and from what I could see .4)
> is missing the files to build for the Xilinx Virtex platform?
>
> Or in other words, I tried to build from 2.6.25.3 for the Xilinx Virtex
> under arch/powerpc (because arch/ppc actually crashes when once apps start
> to run) and it failed when trying to actually create the zImage. I hopped
> over to Xilinx's git server and noticed a bunch of missing entries in the
> boot/Makefile and source code to actually support the complete image build
> for a Xilinx Virtex PPC405.
>
> When is the Xilinx Virtex support going to be mainline official? I need to
> be able to grab a stable kernel and work from there rather than using the
> latest -rc that Xilinx is hosting on their git server.

Working on it.  Biggest problem is getting the device drivers in
shape.  However, other than Ethernet support, current arch/powerpc
(head of Linus' tree, not 2.6.25) should work for building virtex
kernels.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
