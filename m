Date: Fri, 21 May 2004 13:26:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 CPM DP ram free function
Message-ID: <20040521202610.GK6763@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DAE0@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DAE0@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 21, 2004 at 03:16:10PM -0500, Rune Torgersen wrote:
> > Er?  Aren't dpfree/hostfree new functions?  I didn't see them
> > added as exports in your patch, and regardless they belong in
> > comproc.c now.
>
> Try this then
>
> The problem is that on 2.6.x I have never gotten EXPORT() in commproc.c
> (or anywhere else) to work, I have had to put them on ppc_ksyms.c to be
> able to load my modules
>
> I do not know if there is some magic thatI have forgotten to do.

Did you run 'make clean' before trying?  Perhaps there's still a bug
when you add exports to a file that previously didn't have any..

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
