Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ygtR0QYyzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 13:46:38 +1000 (AEST)
Subject: Re: [PATCH] treewide: remove current_text_addr
To: Helge Deller <deller@gmx.de>, Nick Desaulniers <ndesaulniers@google.com>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: ebiederm@xmission.com, tglx@linutronix.de, mingo@redhat.com,
 horms@verge.net.au, natechancellor@gmail.com, pombredanne@nexb.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Tobias Klauser <tklauser@distanz.ch>, Noam Camus <noamc@ezchip.com>,
 Mickael GUENE <mickael.guene@st.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Kees Cook <keescook@chromium.org>, Dave Martin <Dave.Martin@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laura Abbott <labbott@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhc@lemote.com>,
 "Maciej W. Rozycki" <macro@mips.com>, Arnd Bergmann <arnd@arndb.de>,
 David Howells <dhowells@redhat.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>, Ram Pai
 <linuxram@us.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Cornelia Huck <cohuck@redhat.com>, Vasily Gorbik <gor@linux.vnet.ibm.com>,
 Nick Alcock <nick.alcock@oracle.com>,
 Shannon Nelson <shannon.nelson@oracle.com>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
Date: Sat, 25 Aug 2018 19:38:47 -0700
MIME-Version: 1.0
In-Reply-To: <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
Content-Type: multipart/mixed; boundary="------------CE37549B542F2DC07673DCF7"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------CE37549B542F2DC07673DCF7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/25/18 03:48, Helge Deller wrote:
> 
> Currently alpha, s390, sparc, sh, c6x, ia64 and parisc provide an
> inline assembly function to get the current instruction pointer. 
> As mentioned in an earlier thread, I personally would *prefer* if 
> _THIS_IP_ would use those inline assembly instructions on those
> architectures instead of the (currently used) higher C-level
> implementation.
> 

Older ones have as well, e.g. x86.

The only reason to retain the use of an assembly function would be in
the case where either:

a) the C implementation produces bad or invalid code on certain
   architectures;
b) there is a specific requirement that either an absolute or a relative
   value is used in the binary, e.g. due to constraints on relocation.
   The latter particularly comes to mind since the x86-64 implementation
   in assembly will produce movq $.,%reg (which requires relocation)
   instead of the more natural leaq .(%rip),%reg.

In the case (a) those architectures ought to be able to simply

#undef _THIS_IP_
#define _THIS_IP_ blah...

and in case (b) *those specific instances* should be using some kind of
specially flagged function e.g. current_true_ip() vs.
current_linktime_ip() or somesuch.

I also note that a lot of those functions are not marked
__always_inline, which is a serious error should the compiler ever get
the idea to out-of-line these functions, which could potentially happen
as gcc is rather bad at assigning weight to an assembly statement.

I'm also going to throw in a perhaps ugly bomb into this discussion:

_THIS_IP_ seems to be horribly ill-defined; there is no kind of
serialization, and no reason to believe it can't be arbitrarily hoisted
inside a function. Furthermore, *most of the uses of _THIS_IP_ seem to
be either discarded or passed to a function*, and the location of a
function call, unlike _THIS_IP_ is very well defined.

In that case, the use of this mechanism is completely pointless and
ought to be replaced with _RET_IP_.  It seems like most invocations of
_THIS_IP_ can be trivially replaced with _RET_IP_ inside the function,
which would also reduce the footprint of the function call, for example:

__trace_puts() is only ever called with _THIS_IP_ as the first argument;
drop that argument and use _RET_IP_ inside the function (also,
__trace_puts() only ever uses strlen() as the third argument, which gcc
can of course optimize into a constant for the case of a consta t
string, but *is that optimization actually worth it*?  In the case of
__trace_puts(), a variable strlen() would only ever need to be called in
the case of an allocation actually happening -- otherwise str is never
examined -- and again, it increases the *code size* of the call site.
If it was worthwhile it would make more sense to at least force this
into the rodata section with the string, something like the attached
file for an example; however, I have a hunch it doesn't matter.

I wouldn't be surprised if all or nearly all instances of _THIS_IP_ can
be completely removed.

	-hpa

--------------CE37549B542F2DC07673DCF7
Content-Type: text/x-csrc;
 name="str.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="str.c"

#include <stddef.h>
#include <string.h>

#define _RET_IP_ ((unsigned long)__builtin_return_address(0))
#define no_inline __attribute__((noinline))
#define must_inline __attribute__((always_inline)) inline

struct myputs_string {
	size_t len;
	const char *str;
};

int _myputs_struct(const struct myputs_string * const strs);
int _myputs_string(const char *str);
int __myputs(unsigned long ip, const char *str, size_t len);

int no_inline _myputs_struct(const struct myputs_string * const strs)
{
	return __myputs(_RET_IP_, strs->str, strs->len);
}

int no_inline _myputs_string(const char *str)
{
	return __myputs(_RET_IP_, str, strlen(str)+1);
}

#define myputs(s)							\
({									\
	int _rv;							\
	if (__builtin_constant_p(s) &&					\
	    __builtin_constant_p(strlen(s)) &&				\
	    strlen(s)+1 == sizeof(s)) {					\
		static const struct myputs_string _mps = {		\
			.len = sizeof(s),				\
			.str = __builtin_constant_p(s) ? s : NULL,	\
		};							\
		_rv = _myputs_struct(&_mps);				\
	} else {							\
		_rv = _myputs_string(s);				\
	}								\
	_rv;								\
})

int test1(void);
int test2(const char *strx);

int test1(void)
{
	return myputs("Foobar");
}

int test2(const char *strx)
{
	return myputs(strx);
}

		

--------------CE37549B542F2DC07673DCF7--
