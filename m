Message-ID: <39B6B21C.9A3ACA5B@embeddededge.com>
Date: Wed, 06 Sep 2000 17:07:40 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: frowand@mvista.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: question about 'r2' !!!
References: <Pine.LNX.4.10.10009062235520.30076-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> If you're unable to use gcc for building your kernels, ....

With the gcc/gas specific syntax, and the reliance on gcc inline
assembler, there is lots of work to do to make something else
compile this software in any case.

Then, all you have done is the easy part, which is getting a kernel
to boot.  What about applications, libraries and other tools that
actually make a system do something?


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
