Date: Mon, 21 Jan 2002 17:11:24 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: linuxppc-dev@lists.linuxppc.org,
	<debian-powerpc@lists.debian.org>,
	<yellowdog-general@lists.yellowdoglinux.com>
Subject: Radeon DRI support patch
Message-ID: <Pine.BSF.4.44.0201211703480.51387-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For those interested in testing Radeon DRI, I've placed a patch located at
http://www.unixbox.com/~ajoshi/radeon-dri.diff which whould patch cleanly
against recent Ben H.'s kernel.  You must turn on AGPgart support, PCIgart
isn't done yet.

Also, you will need to replace your
/usr/X11R6/lib/modules/dri/radeon_dri.so with

http://www.unixbox.com/~ajoshi/radeon_dri.so.bz2

This was tested on a G4 Dual800 w/ Radeon AGP 32MB board, your results may
vary, so please include machine specs if you reply.


ani

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
