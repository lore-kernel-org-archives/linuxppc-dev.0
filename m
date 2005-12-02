Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 0E3B068802
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 20:52:42 +1100 (EST)
Message-ID: <1133520697.4390273987a6a@webmail.televes.com:443>
Date: Fri,  2 Dec 2005 11:51:37 +0100
From: Alex BASTOS <alebas@televes.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Subject: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am working on a board with a MPC8248 based on ADS8272.
Until now I was working with ppc kernel 2.6.11. Now, it's
time to go up, so I am trying 2.6.15-rc2.

Unfortunately, kernel hangs at boot-up, and with a BDI2000
I have reached the pq2_find_bridges() call, more precisely,
in indirect_read_config(). Now I am a bit lost, as I have
almos any knowledge about PCI.

The board doesn't need PCI support at all, but I need it
active on kernel as it is required by USB HCD stack.

I have tested this on the ADS8272 and i doesn't happends,
so, any clue.

And, has the indirect_read_config any to do with the PCI9
workaround, which is supposed to be corrected on HIP7
devices?

Thanks in advance.

Alex BASTOS
