To: linuxppc-dev@lists.linuxppc.org
Subject: IxMicro TwinTurbo device ID and revison number?
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000514052026S.roikawa@rr.iij4u.or.jp>
Date: Sun, 14 May 2000 05:20:26 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've started major update of Xpmac server mainly for "linux beginners".
For this purpose I need IxMicro TwinTurbo128 PCI device ID and revision
number. Could someone show me your TwinTurbo128's lspci -vvx output with
the precise card model?

The new Xpmac feature includes:
 - Fully fbdev compatible; Uses fb ioctl whenever fbdev is avaialble,
   but automatically switches into the old vc ioctl if fb ioctl fails(ex.
   on the MkLinux). CONFIG_FB_COMPAT_XPMAC section in the kernel will not
   be necessay anymore and the server can start on any fb other than
   /dev/fb0.

 - General pointer device support; Accepts any pointer device and protocol
   to be used as far as it is supported(currently only PS/2 protocol, namely
   PS/2 and USB mice).

 - More acceleration; Supports pattern caching and rewritten acceleration
   code for selected chips.

 - Auto sense supported graphic chips; Scans pci bus and automatically
   detects supported chips and its information even when using offb and
   starts acceleration. Pattern caching is available even on the offb.
   Options -mach64, etc. will be removed. Additionally it contanins minimal
   driver to support offb case.

 - Preference; Stores specified startup options in the "preference" file
   when the server finishes. It is used as a startup configuration next
   time for no-specified options. Because the server doesn't automatically
   corrects only wrong startup options but also wrong values in the
   "preference" file itelf, the "preference" is garanteed safe configuration
   in anytime. Trained users can edit this file to specify startup setting.
   The server can start without the "prefernce", off course.

 - Multihead aware; Implementation will be multihead aware for future
   expansion(I'm rewriting Xpmac DDX).
The maintanance of the server will be over when XFree86 4.0 becomes
stable and easy to use(for beginners, too) state and XFree86 projects
Inc. stops 3.x series maintanace.

I'm not very sure if this attempt isn't a waste of time.
Any suggestion, advice, information, etc. are greatly apprecicated.

Thank you,


Ryuichi.

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
