Date: Thu, 24 Feb 2000 23:00:52 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: dony <dony.he@huawei.com.cn>
cc: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
Subject: Re: LinuxPPC2000 on MPC860
In-Reply-To: <38B5D3E0.F89E6490@huawei.com.cn>
Message-ID: <Pine.LNX.4.21.0002242256560.780-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> > >tty_io.c: process 1 (swapper) used obsolete /dev/cua0 - update software to use /dev/ttyS0
> >
> > I found out that the kernel generates this error message in drivers/char/tty_io.c .
> >
> > Does someone know what this error message means? How to avoid it?

It's a bug in the kernel. Workaround is to make /dev/console a symlink

>        Check you nfs root file, and make sure that the "/dev/console" is a symbol link to
> "/dev/ttyS0", instead of "/dev/cua0" .

Actually /dev/console should not be a symlink.
It's a character device, major 5, minor 1 on every decent system.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
