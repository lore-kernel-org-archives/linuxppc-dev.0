Return-Path: <rth@twiddle.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A2D51B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 10:26:16 +1000 (EST)
Received: from are.twiddle.net (are.twiddle.net [75.149.56.221])
	by ozlabs.org (Postfix) with ESMTP id 66EB0DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 10:26:16 +1000 (EST)
Message-ID: <4AA99666.4090207@twiddle.net>
Date: Thu, 10 Sep 2009 17:14:30 -0700
From: Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
To: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
	to compiler.h
References: <4AA991C1.1050800@caviumnetworks.com>
	<1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>,
	linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	akpm@linux-foundation.org,
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

On 09/10/2009 04:56 PM, David Daney wrote:
> +#ifndef unreachable
> +# define unreachable() do { for (;;) ; } while (0)
> +#endif

#define unreachable() do { } while (1)


r~
