Message-ID: <3A633075.5952B4C0@vacuumgenesis.com>
Date: Mon, 15 Jan 2001 09:16:37 -0800
From: Timothy Ritchey <tritchey@vacuumgenesis.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kswapd Oops
References: <3A625423.E0F6C9AC@vacuumgenesis.com> <3A628C9B.489E401A@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> What other versions of the kernel have you used that seem to work OK?

so far, this is the only version I have gotten to boot completely. I
have tried the montavista 2.2.14-1.2.2_1 kernel, but it crashes after
loading the compressed ramdisk image with:

RAMDISK: Compressed image found at block 0
Kernel panic: VFS: Free block list corrupted
Rebooting in 180 seconds..

>
> What is the silicon revision of the chip?

It is a B5 revision

>
> What were you doing at the time you received this error?

The "Oops: kernel access of bad area, sig: 11" occurs at a couple of
different times. 1) sometimes on boot, it will occur right after kswapd
is enabled, and hang the kernel completely. 2) Sometimes it occurs right
after the:

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Oops: kernel access of bad area, sig: 11

If it gets past these two spots (which is most of the time) it will get
me to the bash# prompt. Once there, it randomly will Oops, but I can hit
return, and be right back at the command prompt (it will Oops even if I
just leave the machine idle and am not running any commands from the
shell). I just recently came across some additional errors like this:

bash# ls
exec.c:278: bad pte 001709c9.
exit_mmap: map count is 14
Segmentation fault

Thanks for any help.

Cheers,
tim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
