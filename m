Message-ID: <3B3A576B.6D2968A8@linux-m68k.org>
Date: Thu, 28 Jun 2001 00:00:11 +0200
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: paulus@samba.org, linuxppc-commit@ppcbk.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: rearrangements in linuxppc_2_4_devel
References: <15161.33091.788459.48900@cargo.ozlabs.ibm.com>	<3B39C8AA.5000605@humboldt.co.uk> <15161.54515.559935.629883@cargo.ozlabs.ibm.com> <3B39E532.7040202@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Adrian Cox wrote:

> Looking at the makefile, APUS links with setup.c. So it's going to link
> with our standard parse_bootinfo, which doesn't take any arguments. I
> suspect APUS needs a bit more work to integrate it into the 2_4_devel tree.

Yes, APUS currently calls its own parse_bootinfo() (amiga/bootinfo.c) in
apus_init().

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
