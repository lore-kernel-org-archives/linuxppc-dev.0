From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: cjw <cjw@daneel.dyndns.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB in 2.5
Date: Fri, 11 Oct 2002 00:01:53 +0200
Message-Id: <20021010220153.15823@192.168.4.1>
In-Reply-To: <Pine.LNX.4.44.0210102015200.4257-100000@zem.cjw.nep>
References: <Pine.LNX.4.44.0210102015200.4257-100000@zem.cjw.nep>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The OHCI driver in 2.5.4x(-ppc) crashes on loading, on my beige G3 with
>PCI USB card (Lucent Microelectronics USS-312 USB Controller (rev 16)). It
>halts the computer after printing the info message. This happens both when
>USB was compiled into the kernel and with USB as modules (crashes when
>loading ohci-hcd.o). Has anyone else seen this?
>
>btw: IDE and SCSI seem to work fine here.

The internal OHCI (Apple's one but it's a lucent part) seems to work (the
last time I tried 2.5.x it did, that is about 2 days ago from linuxppc-
2.5 tree). Maybe you should report to linux-usb mailist list, it might be
a chipset specific issue).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
