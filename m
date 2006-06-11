Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id 99B4B67C89
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Jun 2006 10:05:39 +1000 (EST)
Subject: Re: sleep / wake-up
From: Lee Revell <rlrevell@joe-job.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0606110120270.16586@poirot.grange>
References: <Pine.LNX.4.60.0606102034230.3305@poirot.grange>
	<53107f6e0606101503x4f84cbc0j6f92c601fa464c36@mail.gmail.com>
	<Pine.LNX.4.60.0606110027010.16586@poirot.grange>
	<1149980531.14253.92.camel@mindpipe>
	<Pine.LNX.4.60.0606110120270.16586@poirot.grange>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 20:05:40 -0400
Message-Id: <1149984341.14253.97.camel@mindpipe>
Mime-Version: 1.0
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

On Sun, 2006-06-11 at 01:38 +0200, Guennadi Liakhovetski wrote:
> 
> Yes: "ACPI" - we are talking about a (embedded) PPC... But I thought
> you could "simulate" that without ACPI too. AFAIU, ACPI is the way
> hardware (motherboard / laptop) manufacturers tell you about system's 
> configuration, including how to enter S3. In its absence suspending
> every (e.g., embedded) system you have to _know_ the hardware. E.g.,
> what do they do on Apple ppc laptops? You don't have ACPI there. Is
> there any generic system there or did they just study every new
> ppc-mac and handled it specially? 

It seems that PPC Macs have a hardware PMU:

http://www.resexcellence.com/linux_icebox/01-31-02.shtml

And that some embedded devices handle this at the hardware level with no
OS support needed:

http://ozlabs.org/pipermail/linuxppc-dev/2001-February/010179.html

So AFAICT there's no standard like ACPI - each board does it
differently.

Lee
