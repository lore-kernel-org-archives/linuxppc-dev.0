Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
	by ozlabs.org (Postfix) with ESMTP id E8719B7DED
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 19:21:37 +1000 (EST)
Message-ID: <4BEA73F6.7020400@oss.ntt.co.jp>
Date: Wed, 12 May 2010 18:25:10 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][PATCH 7/12 not tested yet] PPC: introduce __set_bit() like
	function for bitmaps in user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220418.083929bc.takuya.yoshikawa@gmail.com>
	<4BE97F2A.5080900@suse.de>
In-Reply-To: <4BE97F2A.5080900@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
	kvm@vger.kernel.org, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, paulus@samba.org,
	avi@redhat.com, hpa@zytor.com, tglx@linutronix.de,
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
>> +static inline int set_bit_user_non_atomic(int nr, void __user *addr)
>> +{
>> +	u8 __user *p;
>> +	u8 val;
>> +
>> +	p = (u8 __user *)((unsigned long)addr + nr / BITS_PER_BYTE);
>>
>
> Does C do the + or the / first? Either way, I'd like to see brackets here :)

OK, I'll change like that! I like brackets style too :)

>
>
> Alex
>
