Message-ID: <397502B7.9FE5C6C8@routefree.com>
Date: Tue, 18 Jul 2000 18:21:59 -0700
From: "Nikhil G. Daddikar" <ngd@routefree.com>
MIME-Version: 1.0
To: LinuxPPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Enabling Video on the IBM PowerPC 405GP walnut system
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have successfully booted up Monta Vista 6/29 linux kernel on this
board. I  now want to get the video card to work. Any ideas/pointers
would be helpful. Also, I think the address space is not configured
correctly, can somebody confirm this?
Thanks.


/proc/pci reports :
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1014:0156 (IBM) (rev 1).
      Master Capable.  Latency=12.  Max Lat=60.
      Prefetchable 32 bit memory at 0x0 [0x7fffffff].
  Bus  0, device   4, function  0:
    VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
      IRQ 31.
      Master Capable.  Latency=12.  Min Gnt=31.Max Lat=60.
      Non-prefetchable 32 bit memory at 0x0 [0x3ffffff].

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
