Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [75.149.56.221])
	by ozlabs.org (Postfix) with ESMTP id DB341DE117
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 08:20:06 +1000 (EST)
Message-ID: <49E3BA95.5080204@twiddle.net>
Date: Mon, 13 Apr 2009 15:20:05 -0700
From: Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: alpha: half done futex implementation
References: <b4198de60904111755u5c2078c7xcc689dbd78aeb957@mail.gmail.com>	<49E39F3D.4060501@twiddle.net>
	<m263h8i5id.fsf@igel.home>
In-Reply-To: <m263h8i5id.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Oliver Falk <oliver@linux-kernel.at>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
	Jay Estabrook <jay.estabrook@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Richard Henderson <rth@twiddle.net> writes:
> 
>>   switch (op) {
>>     case FUTEX_OP_SET:
>>       __futex_atomic_op("mov %0,%1", ret, oldval, uaddr, oparg);
> 
> That should probably be "mov %4,%1\n"?

You're right.


r~
