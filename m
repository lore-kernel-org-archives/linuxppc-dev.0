Date: Tue, 2 Mar 2004 13:58:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Error compiling 2.6.2
Message-ID: <20040302205850.GC20227@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DA83@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DA83@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 02, 2004 at 02:25:11PM -0600, Rune Torgersen wrote:

>
> Sorry I sendt this with wrong subject....
>
> Hi
> Anybody seen this error?
> I'm getting it while trying to compile 2.6.2 for a 8266 based board,
> using the ELDK 3.0 toolchain (ppc_82xx-gcc v 3.2.2 & ppc_82xx-as ver
> 2.13.90.0.18 )
>
> arch/ppc/kernel/head.S:1660: Error: unsupported relocation against MSR_
>
> Caused by the following line:
> 	li	r5, MSR_		(in function m8260_gorom)

This is fixed in 2.6.3.  Search the archives for the exact patch, or
look at that line in 2.6.3.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
