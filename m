Message-ID: <40842D14.9040708@lucent.com>
Date: Mon, 19 Apr 2004 13:48:36 -0600
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc4xx_find_bridges( ) hangs kernel on Xilinx ML300  (PCI)
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
In-Reply-To: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi-
   I am trying to port the Xilinx PCI code to
an embedded linux kernel.  The code calls
ppc4xx_find_bridges( ) during the kernel initialization
and hangs the kernel.

   I built the GPL 2.4 kernel from the Open Source
archives and it hangs also.

   Then I copied ppc405_pci.c from the GPL source
to my kernel tree and copied  head_4xx.S from the
GPL source to my kernel tree and it still
hangs.

   I'm starting to wonder if there is something
wrong with the PCI support for the Xilinx OCP PCI
core.

   Does anybody have a working PCI device on a
Xilinx Virtex-II Pro using the Xilinx-supplied
PCI core?

-mike wellington
  wellington@lucent.com
  anyplatform@bithead.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
