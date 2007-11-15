Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7D0B8DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 19:48:21 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 15 Nov 2007 09:48:19 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <18235.28312.88899.861687@cargo.ozlabs.ibm.com>
Message-ID: <20071115084819.162500@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net>	<1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net>	<1194594629.6561.34.camel@pasglop>
	<20071110171130.254580@gmx.net>	<1194753340.21340.24.camel@pasglop>
	<20071113212320.85840@gmx.net>	<1194990218.28865.1.camel@pasglop>
	<20071113220655.85840@gmx.net>	<1194997072.28865.5.camel@pasglop>
	<20071114093939.297890@gmx.net>
	<18235.28312.88899.861687@cargo.ozlabs.ibm.com>
Subject: Re: Kernel locks up after calling kernel_execve()
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 15 Nov 2007 08:54:32 +1100
> Von: Paul Mackerras <paulus@samba.org>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> No it's not just for ppc64.  We had a patch that went in some time ago
> to ensure that the M bit was set on various 32-bit platforms because
> otherwise we got data corruption (due to a small cache in the
> northbridge not being kept coherent with the processor cache).
Ah, I thought this was due to a CPU errata, where L2 cache prefetching
causes data corruption with the coherent bit set to 0.

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
