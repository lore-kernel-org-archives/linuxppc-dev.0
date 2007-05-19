Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17998.28739.378409.440833@cargo.ozlabs.ibm.com>
Date: Sat, 19 May 2007 13:34:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
In-Reply-To: <464DAD06.2060504@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
	<464CB460.40905@ru.mvista.com>
	<97d47c2261fe9cd3f1a6c864278a6ab6@kernel.crashing.org>
	<1179464690.32247.370.camel@localhost.localdomain>
	<1179466769.3658.0.camel@localhost.localdomain>
	<1179472096.32247.394.camel@localhost.localdomain>
	<464DAD06.2060504@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dave Liu <r63238@freescale.com>, tglx@linutronix.de, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     Yeah, the classic decrementer is programmed off-by-one.

Actually it's programmed off by slightly less than one half on
average, but it doesn't matter since the error doesn't accumulate.

Paul.
