From: Ruedi.Hofer@ascom.ch
Date: Thu, 24 Feb 2000 12:59:28 +0100 (CET)
Subject: Re: LinuxPPC2000 on MPC860
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FQF00LG1O1J7P@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_DUYgDvvMdgW2CgSDu+5VNQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_DUYgDvvMdgW2CgSDu+5VNQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Some further info.

I'm right now using the ramdisk.image.gz from the LinuxPPC-2000-lite cdrom
as nfs mounted rootdisk. (I installed the ramdisk on the PC)

Like that I get an error message right after the kernel has booted:

>...
>Looking up port of RPC 100003/2 on 10.1.20.2
>Looking up port of RPC 100005/1 on 10.1.20.2
>VFS: Mounted root (NFS filesystem) readonly.
>Freeing unused kernel memory: 32k init
>tty_io.c: process 1 (swapper) used obsolete /dev/cua0 - update software to use /dev/ttyS0

I found out that the kernel generates this error message in drivers/char/tty_io.c .

Does someone know what this error message means? How to avoid it?

TIA, Ruedi



--Boundary_(ID_DUYgDvvMdgW2CgSDu+5VNQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
