Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6CC6BB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 00:33:19 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
	to compiler.h
Date: Fri, 11 Sep 2009 16:32:58 +0200
References: <4AA991C1.1050800@caviumnetworks.com>
	<1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200909111633.00665.mb@bu3sch.de>
Cc: linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, David Daney <ddaney@caviumnetworks.com>,
	Ingo Molnar <mingo@redhat.com>, Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>,
	linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org, akpm@linux-foundation.org,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 September 2009 01:56:42 David Daney wrote:
> +/* Unreachable code */
> +#ifndef unreachable
> +# define unreachable() do { for (;;) ; } while (0)
> +#endif

# define unreachable() do { } while (1)

? :)

-- 
Greetings, Michael.
