Date: Tue, 4 Jul 2000 16:42:13 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
        yellowdog-general@lists.yellowdoglinux.com
Subject: [ANN] New XFree86-pmac rsync tree
Message-ID: <Pine.LNX.4.10.10007041630040.102-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With XFree86 4.x development speeding up, I have placed an rsync tree of
my xfree86/ tree.  This rsync tree can be grabbed with:

rsync -arvz penguinppc.org::xfree86-pmac .


This tree contains the 'bleeding edge' development server and drivers for
XFree86 4.x.  Included are my development Mach64, IMS TwinTurbo 128/3D,
and Chips&Tech 6555x drivers.  The tree also contains the latest Rage128
driver.

This is NOT a full xfree86, simply the xfree86 SERVER tree.  Using this
tree is very simple, all you have to do is grab the X401src-1.tgz tarball
from ftp.xfree86.org, and replace the xc/programs/Xserver/hw/xfree86
directory with the rsync'ed one.

For detailed instructions and information, see:

http://penguinppc.org/usr/xf4


The existence of this tree should facilitate development of these drivers
and keep me from having to constantly update binary drivers :)

Feel free to send me bug reports and/or patches against the tree.

ani

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
