Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <4073B073.40507@com2gether.net>
Date: Wed, 07 Apr 2004 09:40:35 +0200
From: sutra <pierre.sutra@com2gether.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: SPI bus on MPC8xx
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everybody,

I'm a french student, new to this list and i'm actually developping an
interface to dialog via the SPI bus of a MPC852T with an HC908GR4. I
have started my developpement with the driver that Alex Zeffertt made
and i had a surprise when i saw that Alex use some CPM function
(m8xx_cpm_dpalloc, m8xx_cpm_hostalloc, ... )  to implement his module
and that those functions weren't exported in the kernel (/proc/ksyms).
I'd like to konw if it was a time when those functions were exported
since Alex used them and the reasons why nowadays this is no more the case.

Thanks you


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
