Return-Path: <Sellsa@ZIN-TECH.COM>
Received: from zinexc.ZIN.NET (ramp034-158.rampant.com [64.28.34.158])
	by ozlabs.org (Postfix) with ESMTP id F348FDDFB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jun 2008 01:31:49 +1000 (EST)
Message-ID: <486504DC.9040503@zin-tech.com>
Date: Fri, 27 Jun 2008 11:18:52 -0400
From: Aaron Sells <aaron.sells@zin-tech.com>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: Linux on Virtex board with ARCH=powerpc
References: <4860B81F.6070205@computing.dundee.ac.uk>	<20080624140532.E77E333006C@mail5-sin.bigfish.com>	<48614927.8020406@computing.dundee.ac.uk>	<20080624195027.01963640077@mail214-sin.bigfish.com>	<48626FAC.2070904@computing.dundee.ac.uk>	<20080625203435.D3C46778055@mail212-sin.bigfish.com>	<48639871.9020204@computing.dundee.ac.uk>	<20080626132905.2779E1F007F@mail24-dub.bigfish.com>
	<4864DD66.5040909@computing.dundee.ac.uk>
In-Reply-To: <4864DD66.5040909@computing.dundee.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,

Peter Mendham wrote:
> I now have a new and rather bizarre problem, which maybe you or someone 
> else has met before.  I have a simple FPGA design with memory, a sysace 
> and a uart16550 on an ML405 (I've put my hardware to one side for the 
> moment).  It works just fine.  If I swap the uart16550 for a uartlite 
> (remaking the kernel with the correct device tree) I see all the boot 
> messages and the kernel seems to start OK, the root partition is mounted 
> but then I see nothing from /sbin/init.  This is the same root fs that I 
> was using with the uart16550 example I just mentioned.  So it's a known 
> good root fs, but it doesn't appear to be able to output to /dev/console 
> when I have a uartlite instead of a uart16550.  I have selected console 
> support for uartlite.  Any ideas?
> 

I had to modify /etc/inittab on my OpenEmbedded rootfs and replace ttyS0 
with ttyUL0 to get the console working with uartlite on my ML403.

> Thanks,
> -- Peter
> 

Regards,
Aaron
