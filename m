Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BC75FDDEED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 13:17:40 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JwqRs-0006EJ-7f
	for linuxppc-embedded@ozlabs.org; Thu, 15 May 2008 20:17:36 -0700
Message-ID: <17266881.post@talk.nabble.com>
Date: Thu, 15 May 2008 20:17:36 -0700 (PDT)
From: mohit_kumar <mohit.kumar@a-k-a.net>
To: linuxppc-embedded@ozlabs.org
Subject: PowerPC Linux PCI ethernet device Probe Error
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi 
We are using PowerPC Port of Linux 2.6 kernel.
The processor architecture is PPC440EPx and the PCI card is Intel PRO PCI
Adapter card.

e100_probe: Cannot find proper PCI device base address, aborting

If I use linux shell command,lspci -vv
It shows:
lspci -vv
00:0c.0 Class 0200: 8086:1229 (rev 0c)
        Subsystem: 8086:0040
                Interrupt: pin A routed to IRQ 67
        Region 1: I/O ports at <unassigned> [disabled]
        Capabilities: [dc] Power Management version 2

It seems Linux can detect PCI device,Read Configuration Space like
Vendor id, Device Id, Class Id  but others Registers like Device Control,
Interrupt Line, Cache Line Size,
latency Timer and Base Address Registers are not being updated even software
is
writing some values to them . ........Please give me some idea to resolve
the pci access problem...feel free to ask information i missed to mention
anything important...
-- 
View this message in context: http://www.nabble.com/PowerPC-Linux-PCI-ethernet-device-Probe-Error-tp17266881p17266881.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
