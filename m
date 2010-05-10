Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
	by ozlabs.org (Postfix) with ESMTP id 9AEF7B7D5C
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 22:05:28 +1000 (EST)
Message-ID: <4BE7F76B.3060408@oss.ntt.co.jp>
Date: Mon, 10 May 2010 21:09:15 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
	offset macro
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<201005061538.54326.arnd@arndb.de> <4BE7F22E.9070504@oss.ntt.co.jp>
	<201005101401.52182.arnd@arndb.de>
In-Reply-To: <201005101401.52182.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	kvm-ia64@vger.kernel.org, fernando@oss.ntt.co.jp,
	mtosatti@redhat.com, agraf@suse.de, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, Avi Kivity <avi@redhat.com>,
	hpa@zytor.com, tglx@linutronix.de,
	Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>
>> Yes, I'm just using in kernel space: qemu has its own endian related helpers.
>>
>> So if you allow us to place this macro in asm-generic/bitops/* it will help us.
>
> No problem at all then. Thanks for the explanation.
>
> Acked-by: Arnd Bergmann<arnd@arndb.de>

Thanks you both. I will add your Acked-by from now on!

   Takuya
