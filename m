Date: Mon, 26 Apr 2004 15:09:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: okorpil@fh-landshut.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
Message-ID: <20040426220944.GI19246@smtp.west.cox.net>
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 21, 2004 at 03:16:09PM +0200, okorpil@fh-landshut.de wrote:

> Hello!
>
> Target hardware: MVME2100, MPC8240 microcontroller - PowerPC 603e CPU
[snip]
> Is this even possible with the PPCbug, or do I need a Linux-friendly
> bootloader? I initially guessed, that if at bootup everything is
> relocated, that would actually suffice, and no additional information from
> the bootloader is required??

It works from PPCBug.  At least with cramfs, I _believe_ there is, or
has been a problem with creating an image on an LE machine for a BE
machine, and vice versa.  What happens when you try and use an ext2
ramdisk?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
