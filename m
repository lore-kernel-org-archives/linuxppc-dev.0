Subject: Converting zImage to S-records for CLLF/860T
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 25 Nov 1999 17:58:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991125065849.55731F393@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear fellow Embedees,

Now that our RPX CLLF/860T boards have arrived, I'm attempting to download a
kernel built from the mpc8xx-2.2.13.tgz sources via 100Mb Ethernet. The board
expects S-records, and the embedded_notes file mentions using 'zsrec' to
convert the zImage, but I can't find zsrec anywhere and I'm equally unsure of
the magic incantation to objcopy. The output from the obvious:
    powerpc-linux-objcopy -O srec zImage zImage.srec
is far too small to be correct.

Could someone please point me in the right direction to find zsrec?

Thank you,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
