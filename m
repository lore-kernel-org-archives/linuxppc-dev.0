Message-ID: <41EA756DBC9FD0118CFC0020AFDB5C5A188E10@tcint1ntsrv>
From: Zehetbauer Thomas <TZ@link.topcall.co.at>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: kernel ftp ?
Date: Mon, 23 Jul 2001 11:44:02 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BitKeeper is commercial software and therefore not very like to succeed
in the path of kernel devlopment. I think we've had this discussion a
thousand times on lkml. The reasons are numerous even if BitKeeper is
licensed for free to open source developers.

Firstly it is unlikely to be distributed with your favourite linux
distribution. You have to find and download the software first. Of
course I agree that this is a problem of every third party software.

As it is unlikely that a package or at least a binary for your favourite
linux distribution is available it is a maintenance nightmare to track
down library problems and do release upgrades or uninstall it.

To start working with the software you will need to learn another set of
commands, options and parameters.

If are working on some not to be public changes you will have to buy
BitKeeper or use a second source code control system.

And finally if I encounter a problem at 3am in the morning there is no
sourcecode to track it down, I will have to wait until the next day to
call and pay for support.

These are the main reasons I would definitely prefer CVS/FTP/rsync
access to the kernel tree!

Tom

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
