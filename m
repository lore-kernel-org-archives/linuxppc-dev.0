Date: Mon, 26 Feb 2001 13:33:18 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Thomas Graichen <thomas.graichen@innominate.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc initrd problem?
In-Reply-To: <news2mail-97ahue$qt6$1@mate.bln.innominate.de>
Message-ID: <Pine.LNX.4.30.0102261332330.29045-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> i did some more trying now: it seems to work with 16M (maybe with more
> too) if the image is only lightly loaded - but if i fill the 16M
> more it hangs at boot with
>
>   RAMDISK: Compressed image found at block 0

Wouldn't that indicate a size limitation for the compressed ramdisk file
somewhere in the booter?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
