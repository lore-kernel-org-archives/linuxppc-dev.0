Date: Tue, 24 Dec 2002 07:22:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org,
	kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: starting position of linux kernel in memory -- ppc
Message-ID: <20021224142228.GD889@opus.bloom.county>
References: <3E082775.1040503@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E082775.1040503@tataelxsi.co.in>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 24, 2002 at 02:53:01PM +0530, Omanakuttan wrote:

> Hi,
> I cross compiled linux kernel using gnutools for mpc8260 and got a file
> by name zimage.embedded.
> We have ordered for a demo on the target board (8260ADS) and they are
> asking for kernel with start address at 0x0000_0000.
> How will I see that info in the kernel ? Or by default it will place
> itself on 0x0000_0000 ?

Erm.  Can you give more information here?  What firmware?  What 8260
board, specifically?  The 'zImage.embedded' file you mentioned gets
loaded into RAM at 0x0080_0000 by default and when it runs, it will
uncompress the kernel and locate it at 0x0000_0000.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
