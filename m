Subject: Re: GT64260_eth (Ethernet) Driver
From: David Woodhouse <dwmw2@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
In-Reply-To: <40DB2199.2050006@mvista.com>
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>
	 <40DA06BE.204@mvista.com>
	 <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
	 <40DB2199.2050006@mvista.com>
Content-Type: text/plain
Message-Id: <1088147437.4636.114.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 25 Jun 2004 08:10:37 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-24 at 11:46 -0700, Mark A. Greer wrote:
> >Ooh look another one. What's in here that merits it having its own tree
> >and prevents it from being accepted upstream?
> >
> It doesn't "merit" its own tree; it has its own tree because the code is
> not yet ready to be passed upstream but others need to see the code.  If
> you don't want to deal with the code in this tree, don't.  When it is
> ready, and eventually [hopefully] accepted into the kernel.org tree,
> this tree will disappear.

Oh, I definitely want to deal with this tree :)

Do you have a brief list of what still offends you about this rewritten
code, such that you haven't sent it yet? Especially those parts which I
could usefully address myself.

I note there are no platforms actually present which use the 64360.
There's Artesyn Katana support in Kconfig but no actual platform support
for that unless I'm being particularly dim today.

Is the 64360 support expected to work? Is there an older known-working
tree for 64360? I'm looking at the Timesys 2.4 port for the Dy-4
DMV-182, but that doesn't actually seem to boot on my DMV-182 so I lack
confidence in the wisdom of using that as any form of reference ;)

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
