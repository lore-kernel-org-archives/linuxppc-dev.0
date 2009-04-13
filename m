Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2BAADDE0D5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 07:54:40 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Richard Henderson <rth@twiddle.net>
Subject: Re: alpha: half done futex implementation
References: <b4198de60904111755u5c2078c7xcc689dbd78aeb957@mail.gmail.com>
	<49E39F3D.4060501@twiddle.net>
Date: Mon, 13 Apr 2009 23:54:34 +0200
In-Reply-To: <49E39F3D.4060501@twiddle.net> (Richard Henderson's message of
	"Mon, 13 Apr 2009 13:23:25 -0700")
Message-ID: <m263h8i5id.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Richard Henderson <rth@twiddle.net> writes:

>   switch (op) {
>     case FUTEX_OP_SET:
>       __futex_atomic_op("mov %0,%1", ret, oldval, uaddr, oparg);

That should probably be "mov %4,%1\n"?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
