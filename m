Date: Wed, 5 Dec 2001 12:45:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Corey Minyard <minyard@acm.org>,
	Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
Message-ID: <20011205194522.GA28241@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net> <20011205175038.27184@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011205175038.27184@smtp.adsl.oleane.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 05, 2001 at 06:50:38PM +0100, Benjamin Herrenschmidt wrote:

> >I think the reason this wasn't applied is that Paul said something about
> >thiws being horriyingly ugly.  Corey, can you post a patch that changes
> >RELOC(x) into a function and nothing else? :)
>
> I prefer this beeing resolved at compile time. The reason Paul didn't want
> it at first is because he didn't want a workaround for a pre-release gcc
> bug. Since this is becoming a "feature", it makes sense to get the
> workaround. Paulus will confirm or not what I'm saying though...

This was actually being hit by a 3.0.x release at the time I think (and
we worked around it another way).  I'd prefer a clean function over an
ugly macro any day :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
