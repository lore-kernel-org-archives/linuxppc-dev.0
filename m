Date: Wed, 12 Jul 2000 10:44:46 -0400 (EDT)
From: "TWG - pat, mark & steve" <twg@world.std.com>
To: Kwansuk Kim <kskim@neowave.co.kr>
cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel can't library file
In-Reply-To: <NEBBKFENMLEDKDHMEHPJOEPBCAAA.kskim@neowave.co.kr>
Message-ID: <Pine.SGI.3.95.1000712104200.25743A-100000@world.std.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(Sorry, I should ponder a little more before sending)

I left out 2 pieces in my earlier response:

1. Use
	powerpc-linux-objcopy --strip-debug <orig. library> <target
library>

THis greatly reduces the size of the libs, especially helpful when you
want to start using an initrd.

2. Run tcpdump on another console while you're trying to boot (or
ethereal), this will show you the filenames the target is searching for.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
