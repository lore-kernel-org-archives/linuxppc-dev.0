Message-ID: <92E171C34A30D51193CA000103CE74F002C41180@CAREX>
From: Tom Guilliams <tguilliams@sbs.com>
To: "'Gary Thomas'" <gary@mlbassoc.com>,
	Tom Guilliams <tguilliams@sbs.com>
Cc: "'Linux PPC Embedded List'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PPC NvRam Support???
Date: Tue, 25 Feb 2003 14:11:55 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Right-o.  I found a discussion thread regarding trying to put a filesystem
on NVRAM - not what I'm trying to do.  I'll look more closely at the kernel.
What I would like to do is have support for the /dev/nvram node.  That's
what I was referring to when I stated there was no PPC support in the
nvram.c file.  Thanks for your suggestion.

Tom

-----Original Message-----
From: Gary Thomas [mailto:gary@mlbassoc.com]
Sent: Tuesday, February 25, 2003 2:11 PM
To: tguilliams@sbs.com
Cc: Linux PPC Embedded List
Subject: Re: PPC NvRam Support???


On Tue, 2003-02-25 at 14:58, Tom Guilliams wrote:
>
> I'm looking for NVRAM support (/dev/nvram) for the M48T37V 32K x 8
> Timekeeper SRAM chip.  Not only that, but drivers/char/nvram.c in the
> 2.4 development tree doesn't seem to support PPC at all.  I must be
> missing something or going about this the wrong way.  There appears to
> be RTC support for that chipset but no NVRAM.  Can anyone shed some
> light on PPC NVRAM support?  Thanks in advance for any help.

Try looking in arch/ppc/kernel - that's where the RTC/NVRAM support is (in
the 2.4 kernels at least)

--
------------------------------------------------------------
Gary Thomas                 |
MLB Associates              |  Consulting for the
+1 (970) 229-1963           |    Embedded world
http://www.mlbassoc.com/    |
email: <gary@mlbassoc.com>  |
gpg: http://www.chez-thomas.org/gary/gpg_key.asc
------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
