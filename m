Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10EB5DE0A2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 19:42:27 +1000 (EST)
In-Reply-To: <AE456C27-B568-4835-8843-F2A2E2D8FC32@kernel.crashing.org>
References: <b4198de60904111755u5c2078c7xcc689dbd78aeb957@mail.gmail.com>
	<49E39F3D.4060501@twiddle.net>
	<AE456C27-B568-4835-8843-F2A2E2D8FC32@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F29CA01F-869A-4C5C-9A3C-4F6B6ABEE901@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: alpha: half done futex implementation
Date: Tue, 14 Apr 2009 11:45:04 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Oliver Falk <oliver@linux-kernel.at>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
	Jay Estabrook <jay.estabrook@hp.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If either the lwarx or the stwcx. faults, the routine returns -EFAULT
> and doesn't retry (label "3" is the end of the asm).
>
> If the stwcx. fails because the CPU lost the reservation, %1 isn't
> clobbered as far as I see?

Oh, "insn" writes to %1, never mind.


Segher
