Date: Fri, 22 Nov 2002 09:10:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marius Groeger <mag@sysgo.de>
Cc: linuxppc-embedded@lists.linuxppc.org, d.mueller@elsoft.ch,
	Wolfgang Denk <wd@denx.de>, steven.scholz@imc-berlin.de
Subject: Re: 'pImage' and 'uImage' targets
Message-ID: <20021122161054.GS779@opus.bloom.county>
References: <20021122150542.GM779@opus.bloom.county> <Pine.LNX.4.40.0211221655450.4044-100000@mag.devdep.sysgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.40.0211221655450.4044-100000@mag.devdep.sysgo.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 22, 2002 at 05:05:01PM +0100, Marius Groeger wrote:
> On Fri, 22 Nov 2002, Tom Rini wrote:
>
> > Next, is it necessary to have both targets, as they produce the same
> > exact output?  I can see this for 2.4 since I'm sure both work in 2.4
> > and both have insturctions says to use {u,p}Image.  But will the PPCBoot
>
> Since the U-Boot now contains our port to several ARM platforms and
> the i386 port is more than upcoming, we would also need those targets
> in the corresponding arch trees as well. Now how are we going to
> handle _that_ without duplicating Make-code/scripts?

Convincing Linus / Marcelo to put the script into scripts/ and then
getting the arch maintainers to add uImage targets?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
