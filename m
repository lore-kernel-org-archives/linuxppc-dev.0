Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E2300D9.70307@redswitch.com>
Date: Mon, 13 Jan 2003 10:09:29 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: vmlinx and ppcboot
References: <20030111090405.A58F6C608E@atlas.denx.de>
In-Reply-To: <20030111090405.A58F6C608E@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Please try to specify your problem  again,  more  clearly,  with  all
> details  like  the commands you enter and the error messages that are
> printed.
After 'make zImage', here comes the error message.

ppc_8xx-ld -T ../ld.script -Ttext 0x00180000 -Bstatic -o zvmlinux head.o
../comm
on/relocate.o  misc-embedded.o ../common/misc-common.o
../common/string.o ../com
mon/util.o embed_config.o m8xx_tty.o image.o ../lib/zlib.a
misc-embedded.o: In function `decompress_kernel':
misc-embedded.o(.text+0x28): undefined reference to `embed_config'
make[2]: *** [zvmlinux] Error 1

The comments on embed_config.c say that functions in that file are for
those embedded 8xx boards that do not have boot monitor support for
board information. The embed_config() just sets some values of bd_t.
Since I already have ppcboot running, I think I don't need any
embed_config stuff, or even boot stuff. Right?

Thank you very much.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
