Subject: Re: namespace issues with asm-ppc/regs.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Matt Porter <mporter@kernel.crashing.org>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <5ADF885A-E00F-11D8-B9F8-000393DBC2E8@freescale.com>
References: <5ADF885A-E00F-11D8-B9F8-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1090961979.18238.12.camel@gaston>
Mime-Version: 1.0
Date: Tue, 27 Jul 2004 16:59:40 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-07-27 at 16:55, Kumar Gala wrote:
>
> Viro recently submitted some patches to 2.6 which removed some
> names space conflicts that existed between asm-ppc/regs.h (also
> asm-ppc64/regs.h) and various drivers. I'm proposing we remove all non
> SPRN_ scoped references for SPRs. I'm willing to cleanup the ppc32
> side for this change, however I would appreciated someone willing to
> do the same for PPC64.

I wanted to do it too, but feel free to beat me on that

> Let me know if we want to go down this path or if there is some other
> brilliant idea for resolving the namespace issue.
>
> I'm also envious of Viro's ability to get C++ style comments into the
> linux kernel :)

--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
