Message-ID: <XFMail.20010103201404.gthomas@redhat.com>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <017b01c075f0$15265b50$bf0102c8@sc.mcel.mot.com>
Date: Wed, 03 Jan 2001 20:14:04 -0700 (MST)
From: Gary Thomas <gthomas@redhat.com>
To: Rolf Liu <rolfl@sc.mcel.mot.com>
Subject: RE: separate kernel as code segment and data segment for linux p
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 04-Jan-2001 Rolf Liu wrote:
>
> Hi,all,
> I am planning to run linux-ppc on ppc823 FADS board.
> As all know, the kernel is resided in flash rom, then upon power-on, kernel
> is copied to RAM.
> I wonder if I can just put data segment to ram and leave code segment to
> FLASH, just as uClinux
> has done. such method will save some ram space, which makes sense on
> embedded solutions.
> Can you give me a hint how to realize it ?
> Any suggestion is appreciated !

This method is called XIP (for execute in place) and is available on
some other architectures.  I don't know what it would take for the PPC,
but you could look at the work done on the Hitachi SH - I know it's supported
there.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
