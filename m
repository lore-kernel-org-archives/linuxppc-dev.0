From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	<linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Re: Changes to PPC Linux required for GCC 3.1
Date: Wed, 5 Dec 2001 18:50:38 +0100
Message-Id: <20011205175038.27184@smtp.adsl.oleane.com>
In-Reply-To: <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I think the reason this wasn't applied is that Paul said something about
>thiws being horriyingly ugly.  Corey, can you post a patch that changes
>RELOC(x) into a function and nothing else? :)

I prefer this beeing resolved at compile time. The reason Paul didn't want
it at first is because he didn't want a workaround for a pre-release gcc
bug. Since this is becoming a "feature", it makes sense to get the
workaround. Paulus will confirm or not what I'm saying though...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
