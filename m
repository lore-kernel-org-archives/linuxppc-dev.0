Subject: Re: [PATCH]: Fixes CONFIG_CONFIG_CPM2_UART bug in tty_io.c
From: Jeff Angielski <jangiels@speakeasy.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040809232548.GD22109@smtp.west.cox.net>
References: <1092088985.4368.8.camel@localhost.localdomain>
	 <20040809232548.GD22109@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1092096437.6859.4.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 Aug 2004 20:07:18 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It was for the BK linuxppc-2.4 tree.  However, it looks like Dan already
make a patch and fixed it himself.

$ bk sccslog tty_io.c
drivers/char/tty_io.c
  1.34 04/08/06 17:13:21 dan@geefour.embeddededge.com +2 -2
  Typos that needed fixing.


Jeff

On Mon, 2004-08-09 at 19:25, Tom Rini wrote:
> On Mon, Aug 09, 2004 at 06:03:05PM -0400, Jeff Angielski wrote:
>
> > Here is a very small patch to fix a configuration bug in
> > drivers/char/tty_io.c where the CPM2 UART would not work for non-8xx
> > targets.
>
> What tree is this against?  Thanks.
>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
