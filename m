Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 0240167B50
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Jun 2006 20:57:48 +1000 (EST)
Date: Sun, 11 Jun 2006 12:57:46 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: sleep / wake-up
In-Reply-To: <1149984341.14253.97.camel@mindpipe>
Message-ID: <Pine.LNX.4.60.0606111249470.4605@poirot.grange>
References: <Pine.LNX.4.60.0606102034230.3305@poirot.grange>
	<53107f6e0606101503x4f84cbc0j6f92c601fa464c36@mail.gmail.com>
	<Pine.LNX.4.60.0606110027010.16586@poirot.grange>
	<1149980531.14253.92.camel@mindpipe>
	<Pine.LNX.4.60.0606110120270.16586@poirot.grange>
	<1149984341.14253.97.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Sat, 10 Jun 2006, Lee Revell wrote:

> It seems that PPC Macs have a hardware PMU:
> 
> http://www.resexcellence.com/linux_icebox/01-31-02.shtml
> 
> And that some embedded devices handle this at the hardware level with no
> OS support needed:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2001-February/010179.html
> 
> So AFAICT there's no standard like ACPI - each board does it
> differently.

Right, so, without such support in the hardware or without the appropriate 
information all you can do is software suspend-to-disk, I think. That's 
for sleep-states. And just for power-saving you can switch various parts 
off in subsystem-specific ways (e.g., spin down a IDE hd), clock the CPU 
down, but still keep your system __running__, i.e. all processes run just 
as usual only slower.

Thanks
Guennadi
---
Guennadi Liakhovetski
