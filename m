Date: Fri, 27 Aug 2004 15:12:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: [PATCH,RFC] PPC32 Machine Check Handling
Message-ID: <20040827221204.GB30360@smtp.west.cox.net>
References: <1093602389.1862.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093602389.1862.54.camel@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 27, 2004 at 11:26:29AM +0100, Adrian Cox wrote:

> The attached patch rearranges PPC32 machine check handling in order to
> test for internal CPU failures before signalling user processes. This
> makes the behaviour match that of i386.
>
> The patch currently only changes behaviour for 6xx processors. It does
> not enable any extra causes of machine check, but it will turn internal
> CPU faults into kernel panics rather than signals.
>
> The PowerMac and Qspan specific code is moved into platform files. There
> don't seem to be any boards in the tree that actually use Qspan PCI. I'd
> like to hear test reports for PowerMac machines that take machine checks
> on I/O faults.
>
> Paul, Tom: This isn't the finished version, but is there any chance of
> something like this going mainstream?  The current behaviour makes it
> very hard to separate chip failures and cooling problems from
> application bugs.

This seems like a fine idea to me.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
