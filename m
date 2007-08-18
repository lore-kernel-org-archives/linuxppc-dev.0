Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EAE31DDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 11:29:54 +1000 (EST)
In-Reply-To: <18116.61246.856760.243185@cargo.ozlabs.ibm.com>
References: <11867913303733-git-send-email-segher@kernel.crashing.org>
	<d6775e129db48371cdf86e94ddfaa1d15617bb8f.1186773842.git.segher@kernel.crashing.org>
	<18116.61246.856760.243185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5f948fd33e0908c03c07f32ae89834a9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Implement atomic{, 64}_{read,
	write}() without volatile
Date: Sat, 18 Aug 2007 03:29:48 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Instead, use asm() like all other atomic operations already do.
>
>> +static __inline__ long atomic64_read(const atomic_t *v)
>
>> +static __inline__ void atomic64_set(atomic_t *v, long i)
>
> s/atomic_t/atomic64_t/ in both lines.  I've edited my copy of the 
> patch.

Ouch, sorry about that.


Segher
