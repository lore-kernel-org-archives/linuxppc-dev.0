Message-ID: <007b01c3be71$6ec82c20$0400a8c0@eurostudio.local>
From: "AlessandroPPC" <aleppcrossi@libero.it>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: busybox problem
Date: Tue, 9 Dec 2003 17:28:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to all,

To solve a problem with ram root filesystem Wolfgang Denk has suggestes to
me  to use his
SELF ramdisk image.
I have successfully used his package.
But I have found a problem with BusyBox init, when T have tried to
customized the init board
configuration.
The problem is related to /etc/rc.sh init script, in fact editing rc.sh and
rebuilding the ramdisk
image the output init is the following:


  "Bummer, could not run '/etc/rc.sh': No such device or directory"

Notice that /etc/rc.sh is present, is an exutable file and has root
privileges.

Any suggestion is appreciated.
R.R.C.S.C.

Thanks to all
Regards,
Alessandro


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
