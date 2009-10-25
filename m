Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B8BBB7BDB
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Oct 2009 19:13:14 +1100 (EST)
Received: from bzq-79-182-102-73.red.bezeqint.net ([79.182.102.73]:50428
	helo=felix-laptop.lan)
	by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1N1yDu-0003cQ-NP
	for linuxppc-dev@ozlabs.org; Sun, 25 Oct 2009 04:13:11 -0400
Message-ID: <4AE4089C.4050000@embedded-sol.com>
Date: Sun, 25 Oct 2009 10:13:16 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: CompactPCI hotplug on PowerPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Can someone who used CompactPCI hotplug drivers on PowerPC
systems please share their experience ? Any pitfalls that
should be avoided, things to take into consideration, etc.

I may soon be involved in project using 460EX CPU, PLX6254
transparent PCI-PCI bridge, and CompactPCI cards. The system
should use ENUM# interrupt to detect card insertion/deletion.

I'm mostly concerned with PCI-PCI bridge and resource allocation
behind it. Is something that is known to work well ?

Also, cPCI hotplug drivers seem more x86 centric, and not immediately
usable with OF framework. There seems to be no way do pass ENUM# irq
number into the driver. How should one define ENUM# interrupt in
device tree ?

Thanks a lot in advance.

Felix.
