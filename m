Date: Thu, 10 Oct 2002 20:31:59 +0200 (CEST)
From: cjw <cjw@daneel.dyndns.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: USB in 2.5
Message-ID: <Pine.LNX.4.44.0210102015200.4257-100000@zem.cjw.nep>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The OHCI driver in 2.5.4x(-ppc) crashes on loading, on my beige G3 with
PCI USB card (Lucent Microelectronics USS-312 USB Controller (rev 16)). It
halts the computer after printing the info message. This happens both when
USB was compiled into the kernel and with USB as modules (crashes when
loading ohci-hcd.o). Has anyone else seen this?

btw: IDE and SCSI seem to work fine here.


    Christiaan Welvaart


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
