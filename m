Date: Thu, 2 Nov 2000 21:56:32 -0500 (EST)
From: mukesh agrawal <quichem@eecs.umich.edu>
To: Tony Mantler <nicoya@apia.dhs.org>
cc: Linux/PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Promise ATA{66,100} PCI cards work
In-Reply-To: <v04003a00b627c64303c3@[24.70.162.12]>
Message-ID: <Pine.GSO.4.21.0011022148370.27430-100000@dogbert.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Just as a note for anyone interested, with 2.2.17 + pci patches + ide
> patches, both my 9600/200mp and my friend's 7600/120 can talk to the
> Promise ATA66 and ATA100 boards.

FWIW, I tried 2.2.16 + ide patches (no pci patches -- where can they be
found?), and that didn't work on my 7200/75.

I switched to 2.4 (from bitkeeper), and that didn't work initially. I
commented out the part of the driver that checks for the controller having
been disabled by the bios, and it's worked since then.

BTW, anyone have MOL working on 2.4? After it switches to its own virtual
console, it seems to just die.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
