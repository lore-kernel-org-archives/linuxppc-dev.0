Subject: RE: Ramdisk image
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 1 Dec 2000 10:24:51 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A90D5@kolkrabbi.flaga.is>
From: Kári Davíðsson <kd@flaga.is>
To: "Daniel Furse" <daniel.furse@iptest.com>,
        "Linux Embedded List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

The ppc embedded faq at http://members.nbci.com/greyhams/linux points
you
to http://linuxdoc.org/HOWTO/Bootdisk-HOWTO-4.html for instructions on
making
ramdisks. Actually this link is broken (I just found out). You might try

http://www.linux.org/docs/ldp/howto/Bootdisk-HOWTO/index.html which
works for me.

If all fails,

dd if=/dev/zero of=myimage bs=1k count=<size in kb>
mke2fs myimage
mount myimage <mountpoint in your directory structure>
copy the files you want on your ramdisk to <mountpoint in your directory
structure>
umount <mountpoint in your directory structure>
gzip myimage

And you should have a valid ramdisk.

The steps above are from memory. If some of the command do not work
properly it might because of missing options. In all cases check the
manpage for these commands.

Hope this helps,

K.D.


Example

-----Original Message-----
From: Daniel Furse [mailto:daniel.furse@iptest.com]
Sent: 30. nóvember 2000 17:09
To: Linux Embedded List (E-mail)
Subject: Ramdisk image



Hi everyone,

How do I go about creating a ramdisk image for an embedded PPC system? I
downloaded a pre-built image, which is now giving me problems, and I
would
like to create a new one. I have downloaded fileutils, but I have been
unable to cross-compile them (we use RedHat x86 host, with gcc). Is
there a
patch or something? Is there a method/HOWTO/documentation somewhere
about
how to do this?

Many thanks is advance,

Dan Furse


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
