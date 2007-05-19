Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17998.28659.702653.237011@cargo.ozlabs.ibm.com>
Date: Sat, 19 May 2007 13:33:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
In-Reply-To: <1179502773.20519.56.camel@imap.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<1179500217.20519.53.camel@imap.mvista.com>
	<464DC0DC.7050809@ru.mvista.com>
	<1179502773.20519.56.camel@imap.mvista.com>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Daniel Walker writes:

> On Fri, 2007-05-18 at 19:06 +0400, Sergei Shtylyov wrote:
> >     Well, the decrementer frequency may change, at least in theory (if the bus 
> > clock changes).
> 
> Does that happen very often?

If it did, gettimeofday would start reporting seriously wrong values,
since the timebase and the decrementer count at the same rate, and we
don't have any provision for fixing things up if that rate changed.
Fortunately there are no powerpc platforms where the rate is
variable.

Paul.
