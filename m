Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ygFw6lWtzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 13:18:28 +1000 (AEST)
Subject: Re: [PATCH] treewide: remove current_text_addr
From: "H. Peter Anvin" <hpa@zytor.com>
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
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
Message-ID: <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
Date: Sat, 25 Aug 2018 20:16:39 -0700
MIME-Version: 1.0
In-Reply-To: <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
Content-Type: multipart/mixed; boundary="------------E7C8783F0513F369AAD19004"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------E7C8783F0513F369AAD19004
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/25/18 19:38, H. Peter Anvin wrote:
>
> If it was worthwhile it would make more sense to at least force this
> into the rodata section with the string, something like the attached
> file for an example; however, I have a hunch it doesn't matter.
> 

An even nuttier version which avoids the extra pointer indirection.
Read it and fear.

	-hpa


--------------E7C8783F0513F369AAD19004
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
	unsigned short len;
	char str[0];
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

#define ifconst(x,y)	__builtin_choose_expr(__builtin_constant_p(x),(x),(y))

#define myputs(s)							\
({									\
	int _rv;							\
	if (__builtin_constant_p(s) &&					\
	    __builtin_constant_p(strlen(s)) &&				\
	    strlen(s)+1 == sizeof(s) &&					\
	    sizeof(s) <= (size_t)65535) {				\
	static const struct {						\
		struct myputs_string _mps_hdr;				\
		char _mps_str[sizeof(s)];				\
	} _mps = {							\
		._mps_hdr.len = sizeof(s),				\
		._mps_str = ifconst(s,""),				\
	};								\
		_rv = _myputs_struct(&_mps._mps_hdr);			\
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

		

--------------E7C8783F0513F369AAD19004--
