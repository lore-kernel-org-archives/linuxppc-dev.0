Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zXxw3MZPzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 23:37:39 +1000 (AEST)
Subject: Re: [PATCH] treewide: remove current_text_addr
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, deller@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
 Simon Horman <horms@verge.net.au>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, rth@twiddle.net,
 ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
 linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, msalter@redhat.com,
 jacquiot.aurelien@gmail.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, rkuo@codeaurora.org,
 tony.luck@intel.com, fenghua.yu@intel.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, monstr@monstr.eu,
 ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
 green.hu@gmail.com, deanbo422@gmail.com, lftan@altera.com,
 jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 Stafford Horne <shorne@gmail.com>, jejb@parisc-linux.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 palmer@sifive.com, aou@eecs.berkeley.edu, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, dalias@libc.org,
 "David S. Miller" <davem@davemloft.net>, gxt@pku.edu.cn,
 x86@kernel.org, jdike@addtoit.com, richard@nod.at, chris@zankel.net,
 jcmvbkbc@gmail.com, Tobias Klauser <tklauser@distanz.ch>,
 noamc@ezchip.com, mickael.guene@st.com, nicolas.pitre@linaro.org,
 Kees Cook <keescook@chromium.org>, Dave Martin <Dave.Martin@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, alex.bennee@linaro.org,
 Laura Abbott <labbott@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>,
 Mark Rutland <mark.rutland@arm.com>, chenhc@lemote.com, macro@mips.com,
 Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
 sukadev@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 linuxram@us.ibm.com, christophe.leroy@c-s.fr, cohuck@redhat.com,
 gor@linux.vnet.ibm.com, nick.alcock@oracle.com,
 shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com,
 luto@kernel.org, bp@suse.de, dave.hansen@linux.intel.com,
 vkuznets@redhat.com, jkosina@suse.cz, linux-alpha@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
References: <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
 <20180827073358.GV24124@hirez.programming.kicks-ass.net>
 <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
 <20180827131103.GD24124@hirez.programming.kicks-ass.net>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <4d1a8f35-e2fc-70d2-ca0e-44b8574c86f1@zytor.com>
Date: Mon, 27 Aug 2018 06:33:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180827131103.GD24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/18 06:11, Peter Zijlstra wrote:
> On Mon, Aug 27, 2018 at 05:26:53AM -0700, H. Peter Anvin wrote:
> 
>> _THIS_IP_, however, is completely ill-defined, other than being an
>> address *somewhere* in the same global function (not even necessarily
>> the same function if the function is static!)  As my experiment show, in
>> many (nearly) cases gcc will hoist the address all the way to the top of
>> the function, at least for the current generic implementation.
> 
> It seems to have mostly worked so far... did anything change?
> 

Most likely because the major architectures contain a arch-specific
assembly implementation.  The generic implementation used in some places
is completely broken, as my experiments show.

>> For the case where _THIS_IP_ is passed to an out-of-line function in all
>> cases, it is extra pointless because all it does is increase the
>> footprint of every caller: _RET_IP_ is inherently passed to the function
>> anyway, and with tailcall protection it will uniquely identify a callsite.
> 
> So I think we can convert many of the lockdep _THIS_IP_ calls to
> _RET_IP_ on the other side, with a wee bit of care.
> 
> A little something like so perhaps...

I don't have time to look at this right now (I'm on sabbatical, and I'm
dealing with personal legal stuff right at the moment), but I think it
is the right direction.

	-hpa
