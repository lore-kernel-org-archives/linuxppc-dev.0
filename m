Date: Tue, 27 Aug 2002 17:37:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: acurtis@onz.com
Cc: dan@embeddededge.com, linuxppc-embedded@lists.linuxppc.org,
	paulus@samba.org
Subject: Re: 8260/8xx IRQ patch
Message-ID: <20020828003728.GE22875@opus.bloom.county>
References: <20020827173128.20304.h022.c007.wm@mail.directvinternet.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020827173128.20304.h022.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 27, 2002 at 05:31:28PM -0700, acurtis@onz.com wrote:
> > Definatly not for 2.4, for 8xx.  And did you test this on an 8xx board?
>
> I do not have an 8xx board but I have tested it on the 8260. On the 8260 if you
> loaded a module that wanted to call request_irq() you crashed in a stub function.
> No mapping to request_8xxirq() from request_irq().
>
> I could make this 8260 specific if you want.

Look at the -embedded or -dev archives for a simlar patch that I
submitted a few months ago.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
