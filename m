Date: Thu, 11 Apr 2002 15:10:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: tlbwe, rfci instructions and gcc cross assembler
Message-ID: <20020411221033.GF759@opus.bloom.county>
References: <45B36A38D959B44CB032DA427A6E10640167CFAE@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167CFAE@cceexc18.americas.cpqcorp.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 04:53:18PM -0500, Cameron, Steve wrote:

[snip]
> strace /usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/scameron/ppc/testdir/include   -c -o head_4xx.o head_4xx.S

-Wa,-m405 is missing here.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
