Date: Tue, 11 Dec 2001 11:34:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: r3 and bd_t
Message-ID: <20011211183430.GQ22045@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C164F4B.E9A4FCA2@seranoa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C164F4B.E9A4FCA2@seranoa.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 11, 2001 at 01:24:11PM -0500, Andrew Dixon wrote:
>
> Hi All -
>
> I'm trying to boot linux on an sbc8260 using PPCBoot.  (Linux 2.4.16 and
> PPCBoot 1.1.2)  PPCBoot passes a data structure (bd_t) with a lot of
> board information in it.  The way that this is supposed to work (I
> think, please correct me if I'm wrong) is that PPCBoot leaves the
> address of the data structure in r3 and one of the first things that
> linux should do is to copy or obtain this information somehow.  So, my
> question is this: does anyone know where this happens in the code?  I've
> been looking in arch/ppc/kernel/setup.c and this looks like where it
> should happen but I don't see it.

arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
iirc, which will pass it along to platform_init(), which copies it for
safe keeping.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
