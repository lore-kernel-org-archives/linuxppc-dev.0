From: okorpil@fh-landshut.de
Date: Thu, 1 Apr 2004 10:45:18 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial Console / Booting Linux with the PPCbug on MVME2100?
In-Reply-To: <20040331170924.GL13819@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0404011040170.702@ppcproject1>
References: <Pine.LNX.4.58.0403311359540.21912@ppcproject1>
 <20040331170924.GL13819@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


BTW, I just tested modifying the images with mkbugboot, both with the
vmlinux.gz and zImage.prep - will not boot image off the network. Will not
boot image with RB; V (load from ROM/RAM verbose) if loaded at $10000
address either (both bugboot images).

This always leads to Alignment errors, while trying to boot the
zImage.prep off the net directly does not lead to errors but to a system
hang.

I've seen evidence on the list, that the netboot stuff works - most people
seem to have problems transplanting a working configuration into Flash,
but not with netbooting, therefore leading to little useful advice on this
in the list. :(

Hope my config from the previous post is more useful.

Thanks in advance,
Oliver


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
