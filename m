Message-ID: <39358FA0.3C765982@embeddededge.com>
Date: Wed, 31 May 2000 18:18:08 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
CC: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EST SBC8260 & abatron
References: <7283DE19D141D111AD0E00A0C95B195502581D61@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Gessner, Matt" wrote:
>
> A long subject...
>
> I'm having trouble accessing the upper 8MB of the 16MB SDRAM SIMM on this
> board.
> I'm wondering if I don't have something configured wrong in my BDI2000
> config file.

Didn't we discuss this once before?  There were some suggestions posted.

> Also, we're trying to load the linux kernel into this system.
> How are the folks out there doing that?  Via ftp?  Via a bootloader on the
> 2MB FLASH
> chip on the board tied to /CS0?  What exactly?

I am using a high speed serial S-record downloader.  I guess I will
be posting the boot rom and the loader for the EST8260 when I get
a chance later this week.  I then load and flash a kernel the same
way.  I have some flash utilities that run from Linux and just reflash
kernels into different areas for testing.  I have just finished a
program to hack the zImage header so the VxWorks boot rom will load
it.  I only spent about half an hour, so it needs a little cleaning up,
but it seems to work.  I am hoping someone will provide a TFTP loader
for the code I post.......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
