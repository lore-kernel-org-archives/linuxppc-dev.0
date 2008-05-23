Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 272D3DDFE0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 02:44:53 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so171145anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 09:44:52 -0700 (PDT)
Message-ID: <fa686aa40805230944jb6baf6fh601ec7b400a8a0eb@mail.gmail.com>
Date: Fri, 23 May 2008 10:44:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: arch/powerpc, Xilinx, and mainline kernel support
In-Reply-To: <20080523161316.7627978062@mail63-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
	<fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com>
	<20080516223422.C02A26B006F@mail34-dub.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FFA5C22@XMBIL132.northgrum.com>
	<20080523161316.7627978062@mail63-va3.bigfish.com>
Cc: "Koss, Mike \(Mission Systems\)" <mike.koss@ngc.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 10:13 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> Grant, could you post explicit instructions about how to build the
> simpleImage?  I tried it too and couldn't get the makefile rules to
> match my dts.
>
> Mike, Supporting mpmc2 for memory access only is pretty straightforward,
> but supporting the temac/sdma connections is more problematic,
> particularly since we have no plans to update the plb_temac driver for
> ARCH=powerpc.

Oops; my mistake.  I've got a trivial patche in my tree that need to
be merged for the build to work.  I'll get those out ASAP.

In the mean time, add "simpleImage%" to the BOOT_TARGETS line in
arch/powerpc/Makefile.  That will allow you to do:

$ make simpleImage.virtex405-<blah>

where virtex405-<blah> corresponds with a file named
arch/powerpc/boot/dts/virtex405-<blah>.dts

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
