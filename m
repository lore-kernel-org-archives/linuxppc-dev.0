Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17218.31264.61421.415716@cargo.ozlabs.ibm.com>
Date: Tue, 4 Oct 2005 22:48:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Rune Torgersen" <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: RE: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen writes:

> CONFIG_HZ is not broken, but the whole clock configuration is.
> (I poseded something about it for 8260 earlier this summer)
> 
> Basic problem is that CLOCK_TICK_RATE which is used for setting up the
> variables used for advancing the clock, is hardcoded to a value that
> only makes sence for an i386. (it is default set at 1193180Hz which
> happens to be the timer clock for timer1 on an i386 machine)

I do not believe CLOCK_TICK_RATE affects timekeeping at all on ppc or
ppc64 machines, but I could be wrong.  Can you show us where and how
CLOCK_TICK_RATE affects things?

Paul.
