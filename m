Date: Mon, 26 Apr 2004 10:11:56 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Phil Thompson <philt@4bridgeworks.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Serial Driver and IRQ0
Message-ID: <20040426171156.GA13513@gate.ebshome.net>
References: <C18BA5DDB58DD511BD0700C0DF0DD45028B299@NTSERVER4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD45028B299@NTSERVER4>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 26, 2004 at 04:00:42PM +0100, Phil Thompson wrote:
>
> The standard Linux serial driver uses an IRQ number of 0 to indicate a port
> has no interrupt - but UART0 on a 4xx is on IRQ 0.  Therefore interrupts are
> disabled for UART0 (ttyS0).
>
> It's easy enough to hack the standard driver to work around the problem, but
> is there a more elegent solution? I can't believe nobody has had to deal
> with it before.
>

As far as I know, everybody concerned about IRQ0 just hacked generic serial
driver :)

More elegant solution would be to finaly fix it, but looks like nobody
bothered...

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
