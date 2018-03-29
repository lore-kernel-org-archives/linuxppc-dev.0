Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40Bsnd316dzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 04:54:11 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:53:43 +0100
Message-ID: <86y3iarcns.wl-marc.zyngier@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,	Oliver <oohall@gmail.com>,
 Rob Landley <rob@landley.net>,	Shea Levy <shea@shealevy.com>,
 linux-riscv@lists.infradead.org,	Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,	Christoph Hellwig <hch@infradead.org>,
 Richard Henderson <rth@twiddle.net>,	Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,	Matt Turner <mattst88@gmail.com>,	Vineet Gupta
 <vgupta@synopsys.com>,	Catalin Marinas <catalin.marinas@arm.com>,	Will
 Deacon <will.deacon@arm.com>,	Mark Salter <msalter@redhat.com>,	Aurelien
 Jacquiot <jacquiot.aurelien@gmail.com>,	Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,	Yoshinori Sato
 <ysato@users.sourceforge.jp>,	Richard Kuo <rkuo@codeaurora.org>,	Tony Luck
 <tony.luck@intel.com>,	Fenghua Yu <fenghua.yu@intel.com>,	James Hogan
 <jhogan@kernel.org>,	Michal Simek <monstr@monstr.eu>,	Ralf Baechle
 <ralf@linux-mips.org>,	David Howells <dhowells@redhat.com>,	Ley Foon Tan
 <lftan@altera.com>,	Jonas Bonn <jonas@southpole.se>,	Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>,	Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,	Helge Deller
 <deller@gmx.de>,	Benjamin Herrenschmidt <benh@kernel.crashing.org>,	Paul
 Mackerras <paulus@samba.org>,	Michael Ellerman <mpe@ellerman.id.au>,	Palmer
 Dabbelt <palmer@sifive.com>,	Albert Ou <albert@sifive.com>,	Martin
 Schwidefsky <schwidefsky@de.ibm.com>,	Heiko Carstens
 <heiko.carstens@de.ibm.com>,	Chen Liqin <liqin.linux@gmail.com>,	Lennox Wu
 <lennox.wu@gmail.com>,	Rich Felker <dalias@libc.org>,	"David S. Miller"
 <davem@davemloft.net>,	Jeff Dike <jdike@addtoit.com>,	Richard Weinberger
 <richard@nod.at>,	Guan Xuetao <gxt@mprc.pku.edu.cn>,	Thomas Gleixner
 <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,	"H. Peter Anvin"
 <hpa@zytor.com>,	the arch/x86 maintainers <x86@kernel.org>,	Chris Zankel
 <chris@zankel.net>,	Max Filippov <jcmvbkbc@gmail.com>,	Kate Stewart
 <kstewart@linuxfoundation.org>,	Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,	Philippe Ombredanne <pombredanne@nexb.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,	Al Viro
 <viro@zeniv.linux.org.uk>,	Vladimir Murzin <vladimir.murzin@arm.com>,	Linus
 Walleij <linus.walleij@linaro.org>,	Michal Hocko <mhocko@suse.com>,	Andrew
 Morton <akpm@linux-foundation.org>,	Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>,	Rob Herring <robh@kernel.org>,	Kees Cook
 <keescook@chromium.org>,	Vlastimil Babka <vbabka@suse.cz>,	Balbir Singh
 <bsingharora@gmail.com>,	Christophe Leroy <christophe.leroy@c-s.fr>,	Joe
 Perches <joe@perches.com>,	Dan Williams <dan.j.williams@intel.com>,	Wei
 Yang <richard.weiyang@gmail.com>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	Arnd Bergmann <arnd@arndb.de>,	Deepa Dinamani
 <deepa.kernel@gmail.com>,	Daniel Thompson <daniel.thompson@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,	alpha
 <linux-alpha@vger.kernel.org>,	arcml <linux-snps-arc@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net,	linux-c6x-dev@linux-c6x.org,
 Cris <linux-cris-kernel@axis.com>,	"moderated list:H8/300 ARCHITECTURE"
 <uclinux-h8-devel@lists.sourceforge.jp>,	"open list:QUALCOMM HEXAGON..."
 <linux-hexagon@vger.kernel.org>,	linux-ia64@vger.kernel.org,	linux-m68k
 <linux-m68k@lists.linux-m68k.org>,	"open list:METAG ARCHITECTURE"
 <linux-metag@vger.kernel.org>,	Linux MIPS Mailing List
 <linux-mips@linux-mips.org>,	"moderated list:PANASONIC MN10300..."
 <linux-am33-list@redhat.com>,	nios2-dev@lists.rocketboards.org,	Openrisc
 <openrisc@lists.librecores.org>,	Parisc List
 <linux-parisc@vger.kernel.org>,	linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,	linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,	sparclinux
 <sparclinux@vger.kernel.org>,	uml-devel
 <user-mode-linux-devel@lists.sourceforge.net>,	uml-user
 <user-mode-linux-user@lists.sourceforge.net>,
 linux-xtensa@linux-xtensa.org,	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
In-Reply-To: <20180329173247.GF16141@n2100.armlinux.org.uk>
References: <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
 <20180329152749.GC16141@n2100.armlinux.org.uk>
 <CAMuHMdXAckNiUQKT2WU6xaJjbECrifmH6fg_mET+h3iXf_RgDQ@mail.gmail.com>
 <20180329155827.GD16141@n2100.armlinux.org.uk>
 <86zi2qrfgl.wl-marc.zyngier@arm.com>
 <20180329173247.GF16141@n2100.armlinux.org.uk>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Mar 2018 18:32:47 +0100,
Russell King - ARM Linux wrote:
> 
> On Thu, Mar 29, 2018 at 05:53:14PM +0100, Marc Zyngier wrote:
> > On Thu, 29 Mar 2018 16:58:27 +0100,
> > Russell King - ARM Linux wrote:

[...]

> > > I'm not aware of there being an emulated UART in the guest's address
> > > space, so serial based stuff doesn't work.
> > 
> > "earlycon=uart,mmio,0x3f8" is what you're looking for:
> 
> Does that also mean that we have a RTC at the standard PC IO addresses
> as well, but in mmio space?

There is one, together with an i8042. Not exposed in the DT though.

	M.

-- 
Jazz is not dead, it just smell funny.
