Subject: Re: PPC NvRam Support???
From: Gary Thomas <gary@mlbassoc.com>
To: tguilliams@sbs.com
Cc: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1046210297.7412.28.camel@corona>
References: <1046210297.7412.28.camel@corona>
Content-Type: text/plain
Date: 25 Feb 2003 15:10:40 -0700
Message-Id: <1046211040.31018.3032.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-02-25 at 14:58, Tom Guilliams wrote:
>
> I'm looking for NVRAM support (/dev/nvram) for the M48T37V 32K x 8
> Timekeeper SRAM chip.  Not only that, but drivers/char/nvram.c in the
> 2.4 development tree doesn't seem to support PPC at all.  I must be
> missing something or going about this the wrong way.  There appears to
> be RTC support for that chipset but no NVRAM.  Can anyone shed some
> light on PPC NVRAM support?  Thanks in advance for any help.

Try looking in arch/ppc/kernel - that's where the RTC/NVRAM support
is (in the 2.4 kernels at least)

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
