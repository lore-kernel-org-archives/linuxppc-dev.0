Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7959768916
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 13:28:13 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX19p/JMOy6M0Uy4uqrbSYGcPnh3FcBcqf+M@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k0D1eflO008551
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 Jan 2006 17:40:41 -0800
Message-ID: <43C7051D.8000001@ovro.caltech.edu>
Date: Thu, 12 Jan 2006 17:40:45 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Suggestions for a PPC440 board?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I'm evaluating the Yosemite 440EP board at the moment,
with the intention of using it on custom compactPCI
boards. I've got a few questions to ask the group, but
I'll leave those for another email.

In the final system, the cPCI host will be an x86 CPU
(since I already have them), and the cPCI peripherals
will be the 440EP custom boards --- so my intended
target for the 440EP is as a peripheral, whereas the
Yosemite is a host-only development platform (but,
still I have a lot to learn, so its a good place to
start).

To help with the development of PCI drivers, I was thinking
of getting a pre-existing 440-based cPCI board. I haven't
found any 440EP boards, but there are a few 440GP and
440GX boards out there. I need the 440EP FPU in the
real system, but for driver development, one of these
machines would do.

So I have located a few boards, mostly designed as
PMC carrier baseboards. Has anyone used these?

Actis computer       CSBC-6440        440GP
Momentum Computer    Civet-C          440GP
Extreme Engineering  XChange1100/2/4  440GX

Since these boards are designed as carrier boards,
they all use a 21555 transparent/or non-transparent
PCI-to-PCI bridge. I was planning to connect the
440EP directly to the cPCI bus (or at least via
3.3V/5V buffers), so the driver designed against one
of these carrier boards would not quite be identical
(since the host would talk to the 21555 bridge,
not the 440 bridge). So, I might not follow this
route. Alternatively, I could use a PMC, or PrPMC
board, and develop the drivers that way, eg.

Extreme Engineering    Xpedite1000/1  440GX
Artisyn Technologies   PmPPC          440GP

So - anyone have a favorite?

Cheers
Dave Hawkins
Caltech.
