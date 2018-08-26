Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41z4wc1dhzzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 05:34:55 +1000 (AEST)
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
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
Message-ID: <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
Date: Sun, 26 Aug 2018 12:30:37 -0700
MIME-Version: 1.0
In-Reply-To: <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
Content-Type: multipart/mixed; boundary="------------5E98DEB96C9E8225D80004DF"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------5E98DEB96C9E8225D80004DF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Here is a full-blown (user space) test program demonstrating the whole
technique and how to use it.

	-hpa


--------------5E98DEB96C9E8225D80004DF
Content-Type: text/x-csrc;
 name="str.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="str.c"

#include <stddef.h>
#include <string.h>

#define _RET_IP_ ((unsigned long)__builtin_return_address(0))
#define noinline __attribute__((noinline))
#define used __attribute__((used))
/* __always_inline is defined in glibc already */
#define ifconst(x,y)	__builtin_choose_expr(__builtin_constant_p(x),(x),(y))
static inline void notailcall(void)
{
	asm volatile("");
}

/* Change this to a null string to make all functions global */
#define STATIC static

struct myputs_string {
	unsigned short len;
	char str[0];
};

STATIC int _myputs_struct(const struct myputs_string * const strs);
STATIC int _myputs_string(const char *str);
STATIC int __myputs(unsigned long ip, const char *str, size_t len);

#if 1

#include <stdio.h>

STATIC void dump_caller(unsigned long where)
{
	const char *opname = NULL;
	const char *wheretoname = NULL;
	char ichar;
	unsigned long whereto = 0;

#if defined(__i386__) || defined(__x86_64__)
	char opname_buf[4];
	unsigned char opcode;
	
	where -= 5;
	opcode = *(unsigned char *)where;

	switch (opcode) {
	case 0xe8:
		opname = "call";
		whereto = where + 5 + *(signed int *)(where + 1);
		break;
	case 0xe9:
		opname = "jmp";
		whereto = where + 5 + *(signed int *)(where + 1);
		break;
	default:
		snprintf(opname_buf, sizeof opname_buf, "?%02x", opcode);
		opname = opname_buf;
		break;
	}

#elif defined(__sparc__)
	const char regtype[4] = "gilo";
	unsigned int opcode, op1, op3, ibit;
	signed int simm13, simm30;
	char opname_buf[32];
	char *p;

	where -= 8;
	
	opcode = *(signed int *)where;
	op1 = opcode >> 30;
	op3 = (opcode >> 19) & 0x3f;
	ibit = (opcode >> 13) & 1;
	simm13 = (opcode & 0x1fff) << 2;
	simm30 = (opcode & 0x3fffffff) << 2;

	opname = opname_buf;
	
	if (op1 == 1) {
		opname = "call";
		whereto = where + simm30;
	} else if (op1 == 2 && op3 == 0x38) {
		if (ibit) {
			snprintf(opname_buf, sizeof opname_buf,
				 "jmpl %%%c%u %c 0x%x",
				 regtype[(opcode >> 17) & 3],
				 (opcode >> 14) & 7,
				 simm13 < 0 ? '-' : '+',
				 abs(simm13));
		} else {
			snprintf(opname_buf, sizeof opname_buf,
				 "jmpl %%%c%u + %%%c%u",
				 regtype[(opcode >> 17) & 3],
				 (opcode >> 14) & 7,
				 regtype[(opcode >> 3) & 3],
				 opcode & 7);
		}
	} else {
		snprintf(opname_buf, sizeof opname_buf,
			 "?0x08x", opcode);
	}
#else
	/* Unknown architecture */
#endif
	if (whereto == (unsigned long)_myputs_struct) {
		wheretoname = "_myputs_struct";
	} else if (whereto == (unsigned long)_myputs_string) {
		wheretoname = "_myputs_string";
	} else {
		wheretoname = "?";
	}

	ichar = '[';
	
	if (opname) {
		printf("%c%p: %s",
		       ichar, (void *)where, opname);
		ichar = ' ';
	}
	if (whereto) {
		printf("%c%p <%s>", ichar, (void *)whereto, wheretoname);
		ichar = ' ';
	}
	if (ichar != '[')
		putchar(']');
}
	
STATIC int __myputs(unsigned long where, const char *str, size_t len)
{
	size_t slen = strlen(str);
	size_t rv;
	
	len--;
	rv = printf("%p: \"%.*s\"%*s", (void *)where, (int)len, str,
		    16-(int)slen, "");
	dump_caller(where);
	if (slen != len)
		printf(" <err: strlen = %zu, len = %zu>\n", slen, len);
	else
		printf(" <ok: len = %zu>\n", len);
	
	return rv;
}

STATIC int noinline _myputs_struct(const struct myputs_string * const strs)
{
	return __myputs(_RET_IP_, strs->str, strs->len);
}

STATIC int noinline _myputs_string(const char *str)
{
	return __myputs(_RET_IP_, str, strlen(str)+1);
}
#endif

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
	notailcall();							\
	_rv;								\
})

STATIC int test1(void);
STATIC int test2(const char *strx);

STATIC int test1(void)
{
	return myputs("Foobar");
}

STATIC int test2(const char *strx)
{
	return myputs(strx);
}

int main(int argc, char *argv[])
{
	(void)argc;

	test1();
	test2(argv[0]);
	return 0;
}

--------------5E98DEB96C9E8225D80004DF--
