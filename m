Date: Wed, 12 Dec 2001 16:57:11 -0600 (CST)
From: Jim Thompson <jim@smallworks.com>
Message-Id: <200112122257.QAA07497@hosaka.smallworks.com>
To: jtm@smoothsmoothie.com, trini@kernel.crashing.org
Subject: Re: r3 and bd_t
Cc: andrew.dixon@seranoa.com, linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
>> iirc, which will pass it along to platform_init(), which copies it for
>> safe keeping.
>
> I think the 8260 uses arch/ppc/kernel/head.S instead of head_8xx.S.

And the 8245?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
