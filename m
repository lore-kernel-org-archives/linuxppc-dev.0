Message-ID: <39DE819F.A0B840E6@serialsystem.com.sg>
Date: Sat, 07 Oct 2000 08:51:27 +0700
From: Jari <jari.nguyen@smartstors.com>
Reply-To: jari.nguyen@smartstors.com
MIME-Version: 1.0
To: jonb@marel.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with shared libraries in HHL with initrd
References: <OF2290EC0A.032808E8-ON00256970.004061A5@marel.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

jonb@marel.is wrote:

>
> I seems the system expects to find the shared libraries in some other
> directory than /lib.
>

that 's right! If you use hhl 1.2
you should have a link to /
/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux
as you have in your NFS root filesystem.

> Can anyone give me directions ?
> Does someone have a "minroot.tar.gz" made with HHL 1.2 ?

I don't have, but minimum ramdisk is depend on
which application you want to support.
if you just want to boot , configure IP address, mount, see my list:

other dir is empty

/bin
-rwxr-xr-x    1 root     root       564644 Sep 27 08:52 bash
-rwxr-xr-x    1 root     root        39480 Aug  8 15:22 ifconfig
-rwxr-xr-x    1 root     root        30344 Aug  8 15:25 init
-rwxr-xr-x    1 root     root        26096 Aug  8 15:24 modprobe
-rwxr-xr-x    1 root     root        56652 Aug  8 15:27 mount
lrwxrwxrwx    1 root     root            4 Oct  3 14:54 sh -> bash
-rwxr-xr-x    1 root     root        25500 Aug  8 15:27 umount

/lib
-rwxr-xr-x    1 root     root        93544 Sep 29 08:56 ld-2.1.3.so
lrwxrwxrwx    1 root     root           11 Oct  3 14:54 ld.so.1 -> ld-2.1.3.so

-rwxr-xr-x    1 root     root      1052892 Sep 29 08:51 libc-2.1.3.so
lrwxrwxrwx    1 root     root           13 Oct  3 14:54 libc.so.6 ->
libc-2.1.3.so
-rwxr-xr-x    1 root     root        11372 Sep 29 08:56 libdl-2.1.3.so
lrwxrwxrwx    1 root     root           10 Oct  3 14:54 libdl.so -> libdl.so.2

lrwxrwxrwx    1 root     root           14 Oct  3 14:54 libdl.so.2 ->
libdl-2.1.3.so
-rwxr-xr-x    1 root     root        40268 Sep 27 07:57 libnss_files-2.1.3.so
lrwxrwxrwx    1 root     root           17 Oct  3 14:54 libnss_files.so ->
libnss_files.so.2
lrwxrwxrwx    1 root     root           21 Oct  3 14:54 libnss_files.so.2 ->
libnss_files-2.1.3.so
lrwxrwxrwx    1 root     root           19 Oct  3 14:54 libtermcap.so ->
libtermcap.so.2.0.8
lrwxrwxrwx    1 root     root           19 Oct  3 14:54 libtermcap.so.2 ->
libtermcap.so.2.0.8
-rwxr-xr-x    1 root     root        13832 Sep 29 08:56 libtermcap.so.2.0.8
/etc
-rw-r--r--    1 root     root         2045 Aug  8 15:21 DIR_COLORS
-rw-r--r--    1 root     root           32 Sep 27 08:52 fstab
-rw-r--r--    1 root     root           97 Aug 10 02:17 group
-rw-r--r--    1 root     root         2880 Aug  8 15:28 inetd.conf
-rw-r--r--    1 root     root         1317 Oct  3 13:19 inittab
-rw-------    1 root     root           60 Oct  3 13:25 ioctl.save
-rw-r--r--    1 root     root           50 Oct  3 13:25 mtab
-rw-r--r--    1 root     root           78 Aug 10 02:17 passwd
-rw-r--r--    1 root     root         1186 Aug 10 02:17 protocols
-rwxr-xr-x    1 root     root          212 Oct  3 15:00 rc.sysinit
-rw-r--r--    1 root     root         1595 Aug  8 14:38 rpc
-rw-r--r--    1 root     root         4400 Apr  9  1997 services
-rw-r--r--    1 root     root         2677 May  8  1999 termcap

hope this help,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
