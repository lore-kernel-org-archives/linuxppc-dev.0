Return-Path: <david.hagood@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id ACBE2B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 00:12:19 +1000 (EST)
Received: by gxk28 with SMTP id 28so2083835gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 07:12:17 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id B9217C7B8042
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 09:12:13 -0500 (CDT)
Message-ID: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
Date: Tue, 21 Sep 2010 09:12:13 -0500
Subject: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm new to developing on the PPC (most of my experience is on x86), and I
have a couple of questions about mapping of interrupts on the PPC,
specifically on the Freescale 8641D embedded CPU.

1) How does one allocate interrupt vectors for the embedded devices, such
as the MPIC? All the kernel how-tos are really targeting the x86 and PCI,
so I've been unable to find a good document on "that which is not an X86".

2) Are there any good guides to programming the PPC generally, and the
MPC8641 specifically, that I can go read to answer my other questions?

I'm trying to write a driver to map the 8641D's PCIe controllers *as
endpoints* into something frobablbe from user space - to allow setting the
BARs and outbound address translation units via sysfs files, and to allow
mapping of inbound interrupts to sysfs "doorbell"-style files. If I can
get it worked out I want to submit it back to the kernel for general
distribution.

If anybody has any insights, I'd greatly appreciate it if you'd copy my
work email (david.hagood at aeroflex.com) as well (I am using my personal
email as work insisted upon adding a one paragraph "wart" to all outbound
email that isn't acceptable for a list like this.)

Also, if anybody out there has experience with the 8641D PEX's in endpoint
mode and wouldn't mind answering a couple of questions about programming
the OWBARs, I'd be greatly obliged.
