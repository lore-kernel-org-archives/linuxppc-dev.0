Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <39577443.7FBC6ACD@lucent.com>
Date: Mon, 26 Jun 2000 09:18:27 -0600
From: Steven Tarr <tarr@lucent.com>
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
Subject: Re: omitted kernel sections
References: <20179.962030438@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I offer our solution to the problem as an additional data point. I added a command

to the boot rom code that downloads a file to any supplied address via tftp then

jumps to that address plus 0x1000. The offset of 0x1000 is to get over the

ELF header. In this case, I leave the the LINUX build environment alone

and still get a quick boot turnaround.

The commercial BDM/JTAG debuggers are almost worthless after the MMU

is enabled. Only in a "after the fact" case are they of any use. We, collectively,

need to continue to bellyache to the vendors about the short coming.......

cheers --

tarr

--
Steve Tarr
tarr@lucent.com
303-538-4056


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
