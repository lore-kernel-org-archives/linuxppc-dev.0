Subject: Re: kernel oops due to unaligned access with lswi
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Paul Mackerras <paulus@samba.org>
Cc: Olaf Hering <olh@suse.de>, Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <16310.51046.819605.41542@cargo.ozlabs.ibm.com>
References: <20031115210449.GA10105@suse.de>
	 <16310.51046.819605.41542@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1068959230.4644.52.camel@gaston>
Mime-Version: 1.0
Date: Sun, 16 Nov 2003 16:07:10 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-11-16 at 11:40, Paul Mackerras wrote:
> Olaf,
>
> > 	lswi 9,31,8
> > 	stswi 9,28,8
> >
> > s = r31. How can gcc be sure that s aligned?
>
> What machine is this?  I looked at the manuals for 750, 7450, POWER4
> and they all handle unaligned string ops in hardware.  The alignment
> handler doesn't handle string ops, I believe, although it could.  And
> which arch (ppc32 or ppc64)?

One of your old friends actually:

olaf> pmac 7200/90 with 601 cpu.

:)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
