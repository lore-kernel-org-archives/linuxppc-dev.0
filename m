Date: Wed, 8 Oct 2003 23:24:03 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: General porting question
In-Reply-To: <006e01c38e1b$5f72b500$2803050a@JackyLam>
Message-ID: <Pine.LNX.4.44.0310082322160.17168-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 9 Oct 2003, Jacky Lam wrote:
> Dear all,
>
>     Could anyone give me some notes/idea what should be take care to port an
> x86 PCI card driver to powerpc walnut platform? I try several
> cards(ethernet, audio) which run well on my PC by cross-compiling the
> drivers. They can be recognized successfully, but none of them works. Walnut
> seems don't be able to receive any interrupt from the cards.
>
>     I guess there must be something about PCI implementation in PPC
> different from x86. Is there any expert on PPC PCI can tell me what happen?
> Or any related documentation can help?

Best guess, the driver doesn't handle any of the endian issues.

PPC is a big-endian processor, x86 is little endian. Most likely you've
got data that needs to be byte swapped in order to work. Best way I know
of to find out if this is the case is using a PCI bus analyzer to
watch the PCI bus.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
