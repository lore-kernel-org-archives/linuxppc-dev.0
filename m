Message-ID: <3D777C99.97AF4D14@mvista.com>
Date: Thu, 05 Sep 2002 11:47:37 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Lauri Ojantakanen <lauri.ojantakanen@solidtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting sandpoint from ide disk
References: <200209051316.19309.lauri.ojantakanen@solidtech.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lauri Ojantakanen wrote:

> Hi,
>
> does anyone have a good solution for booting sandpoint X3 (cpu 7410, altivec
> supported) from ide hard disk? Dink32 does not seem to support anything like
> that and ppcboot does not seem to support that CPU.

If you want to stay with DINK, you can put the zImage in flash and set DINK up
to automatically (or not) jump to where you put it.  The zImage will relocate
itself, uncompress the kernel (in the proper location) and then boot.  With the
correct cmdline, you can use an IDE disk partition for your root filesystem.
Unless you hack DINK, you won't be able to boot a kernel actually sitting on
the IDE disk, you have to put it in flash or get it into memory some other way
first.  As others have already said, you can always use PPCBoot.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
