From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel linking segfaults??
Date: Sat, 13 Oct 2001 01:22:01 +0200
Message-Id: <20011012232201.8182@smtp.adsl.oleane.com>
In-Reply-To: <200110122149.XAA03908@piglet.grunz.lu>
References: <200110122149.XAA03908@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Now that Ben fixed the serial console problem, I've tried again to
>compile recent 2.4 kernels (2.4.12-benh0 that is) on my venerable 7600.

rsync again.

I inadvertently left pte_young() macro definition commented out
in my copy of pgtable.h (I was checking nobody was using it).

The latest pull from _devel actually added some code that use
it. Strangely, instead of giving a link error, it causes ld to
just segfault ! So it's a source bug triggering an ld bug ;)

I fixed the kernel, the ld bug no longer manifest itself.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
