Date: Fri, 26 Nov 1999 18:34:14 +0100
To: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
CC: paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: New iBook/iMac/G4 kernel & yaboot 0.3
Message-Id: <19991126183414.022934@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I've uploaded a new version of my kernel for new machines. I made a lot
of cleanup and sync'ed with Paul latest 2.2.14 source tree. The iBook ADB
and Trackpad now works normally and this kernel can be booted by yaboot.
I added setting of the colormap to the logo colors (so at least the text
mode installer is useable) when using offb and booting from OF (when
supported by the OF driver, which is the case for ATI based machines).

I've also updated slightly yaboot (it leaves more space between the
kernel and ramdisk, ramdisk tended to fail on new iMac). Still no doc,
but basically, you can do normal OF boot and netboot. I didn't fix the
config file name vs. FAT (yaboot.conf -> yaboot.cnf) yet.

Paul, I think this version could be merged, but please check I didn't
break IDE on other machines.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
