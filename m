Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F290506.3060304@imc-berlin.de>
Date: Thu, 31 Jul 2003 14:01:10 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: large file support?
References: <3F28EFD6.3070803@imc-berlin.de>
In-Reply-To: <3F28EFD6.3070803@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:

> how could I find out if the kernel and the glibc I am using will
> correctly supprot large files (>2GB)?

I reckon my app does not support large files. Since after writing 2GB
to a file

~ # ls -lh /mnt/intern/HDD_STRESS/2003-07-31\ 12-27-34\ \(1\)/
-rw-r--r--    1 root     root         1.0G Jul 31 13:57 K001_G0.raw
-rw-r--r--    1 root     root         1.0G Jul 31 13:57 K002_G0.raw
-rw-r--r--    1 root     root         2.0G Jul 31 13:57 V001_G0.raw
~

it claims "disk full" although

~ # df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/mtdblock0            6.9M      5.1M      1.8M  74% /
/dev/shm                  7.1M     24.0k      7.1M   0% /var
/dev/hda1                 9.2G      4.0G      4.7G  46% /mnt/intern

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
