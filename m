Date: Sun, 25 Feb 2001 23:52:35 -0600 (CST)
From: Ramprasad Rao <ramp@oddjob.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: XFree86 4.0.xx + Display corruption + ati + mach64  
Message-ID: <Pine.GSO.4.10.10102252338330.13356-100000@oddjob.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm using the XF4.0.99 rpms and get a very strange problem on my
display. There are small underscore characters that scroll across my
display from top to bottom approximately 1/2 inch from the left edge of
screen. This corruption mainly occurs at color depths of 15/16 and above
and for resolutions of 1280x1024. No problems at 1024x768 or below.
I get the same corruptions even with XFree86-3.3.6-20.

Kernel: 2.4.0-test11
Video (from dmesg):
atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 6M SGRAM, 14.31818 MHz XTAL, 23
0 MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on PCI
MacOS display is /pci/ATY,RagePro_C

The monitor is a 19" Viewsonic PF 790.

It is quite possible that this is not a PPC specific problem but I was
wondering if anyone on this list has had this problem.

Thanks in advance for your help,
Ram


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
