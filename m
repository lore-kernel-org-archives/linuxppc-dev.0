Message-Id: <v03110702b445e72e876d@[209.183.129.110]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 3 Nov 1999 08:21:17 -0500
To: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org, atong@uiuc.edu
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Source for new Xpmac and Getting it into next XF* RPM
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I would like to get the final version of Ryuichi Oikawa's Xpmac server
which is accelerated for Mach 64 and Rage 128 into the next official
release of the XFree* rpm/srpm set for PPC.

I have available both source code diffs from Tom's 3.3.5 srpm and a
replacement powermac directory that can just be dropped in the source tree
to replace the old one.

Included in this version is support for both usb and adb mice and support
for both 16bpp/15planes and 32bpp/24planes including some recent fixes by
Ryuichi for both Mach64 and Rage 128.

Please let me know who should get these patches or how I go about getting
them in the next release.

Anthony, (or anyone else working on XF68) if you want the source to see
what Ryuichi has done for 16bpp to help speed up XF68FB_Dev development,
please let me know and I will post it for you.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
