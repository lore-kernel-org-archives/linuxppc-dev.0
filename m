Message-ID: <3A7A14BD.C56A5D44@wvi.com>
Date: Thu, 01 Feb 2001 18:00:29 -0800
From: Jim Potter <jrp@wvi.com>
MIME-Version: 1.0
To: jlhagen@collins.rockwell.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trouble creating ramdisk over 8MB - could someone explain this to me
References: <OFCB2243A7.F8689577-ON862569E6.00792F78@collins.rockwell.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been able to successfully alter the ramdisk size by running "make
menuconfig", go to "block devices" then setting the "ramdisk size' to 16384.
make vmlinux.  Serve with hot bread and beer.


> Hello,
>
> I'm trying to set up a 10MB ramdisk for our VME boards. I'm running in to
> this
>
> dd if=/dev/zero of=/dev/ram bs=1k count=10240
> dd: /dev/ram: No space left on device
> 8193+0 records in
> 8192+0 records out
>
> and
>
> mke2fs -vm0 /dev/ramdisk 10240
> mke2fs 1.18, 11-Nov-1999 for EXXT2 FS 0.5b, 95/08/09
> mke2fs: Filesystem larget than apparent filesystem size.
> Proceed anyway? (y,n)
>
> For 8MB dd and mke2fs don't give me problems and changing
> drivers/block/rd.c rd_size to 8192 works as expected but I can't
> figure out why larger than 8 gives me problems.
>
> I would appreciate the help.
> John
>

--
Sincerely,

Jim Potter
45th Parallel Processing
jrp@wvi.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
