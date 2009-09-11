Return-Path: <David.Daney@caviumnetworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ABFB9B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 01:59:28 +1000 (EST)
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id 0B560DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 01:59:27 +1000 (EST)
Message-ID: <4AAA73A4.9010601@caviumnetworks.com>
Date: Fri, 11 Sep 2009 08:58:28 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
	to compiler.h
References: <4AA991C1.1050800@caviumnetworks.com>
	<1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
	<200909111633.00665.mb@bu3sch.de>
In-Reply-To: <200909111633.00665.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org, akpm@linux-foundation.org,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Buesch wrote:
> On Friday 11 September 2009 01:56:42 David Daney wrote:
>> +/* Unreachable code */
>> +#ifndef unreachable
>> +# define unreachable() do { for (;;) ; } while (0)
>> +#endif
> 
> # define unreachable() do { } while (1)
> 
> ? :)

Clearly I was not thinking clearly when I wrote that part.  RTH noted 
the same thing.  I will fix it.

Thanks,
David Daney
