Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
	by ozlabs.org (Postfix) with ESMTP id F1F29B7DF6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 19:16:12 +1000 (EST)
Message-ID: <4BEA72B0.4010105@oss.ntt.co.jp>
Date: Wed, 12 May 2010 18:19:44 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][PATCH 0/12] KVM, x86, ppc, asm-generic: moving dirty bitmaps
	to user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<4BE97DFA.1060408@suse.de>
In-Reply-To: <4BE97DFA.1060408@suse.de>
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


>> [To ppc people]
>>
>> Hi, Benjamin, Paul, Alex,
>>
>> Please see the patches 6,7/12. I first say sorry for that I've not tested these
>> yet. In that sense, these may not be in the quality for precise reviews. But I
>> will be happy if you would give me any comments.
>>
>> Alex, could you help me? Though I have a plan to get PPC box in the future,
>> currently I cannot test these.
>>
>
> Could you please point me to a git tree where everything's readily
> applied? That would make testing a lot easier.

OK, I'll prepare one. Probably on sourceforge or somewhere like Kemari.

Thanks,
   Takuya


>
> Alex
>
