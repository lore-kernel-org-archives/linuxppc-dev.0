Message-ID: <3A64C847.D2414D1D@mvista.com>
Date: Tue, 16 Jan 2001 17:16:39 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: KERNELBASE and MMU
References: <3A648564.671DDDD5@tei.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Borlizzi Giacomo wrote:

> My configuration foreseen  KERNELBASE set to 0x00000000 instead of
> 0xC0000000

I don't really understand, but you should not be changing anything
in the source code or Makefiles or configuration files that affect
the MMU or virtual address mapping.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
