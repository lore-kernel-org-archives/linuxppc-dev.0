Message-ID: <3CD80A2A.CF796A79@lvl7.com>
Date: Tue, 07 May 2002 13:08:58 -0400
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: "Jeffrey W. Daugherty" <jwdaugherty@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux w/o disk, network, or ROM
References: <Pine.LNX.4.44.0205071135570.29700-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Jeffrey W. Daugherty" wrote:

> I've tried setting ROOT_DEV to MKDEV(RAMDISK, 0) in setup.c
> and cmdline argument "root=/dev/ram".
>
> Does anyone have any suggestions?  What might be missing either
> in kernel configuration or platform_init()?  Help!

Are you sure that the kernel is recoginzing your command line
parameters?  It should echo them out in an earlier boot message.

My guess is that you have a mistake somewhere in passing the command
line parameters to the kernel, leaving the kernel unable to find it's
root fs.  YMMV... :-)

John

P.S.  Another possibility is that your initrd image isn't getting
uncompressed correctly or to the correct location...
--
John W. Linville
LVL7 Systems, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
