Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17263.58185.110462.536522@cargo.ozlabs.ibm.com>
Date: Tue, 8 Nov 2005 10:29:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131356850.27347.17.camel@baythorne.infradead.org>
References: <1131264050.10031.265.camel@baythorne.infradead.org>
	<17261.57380.473046.69200@cargo.ozlabs.ibm.com>
	<1131356850.27347.17.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix ppc32 smp build.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> We make no attempt to sync the timebases on quad powersurge, as far as I
> can tell -- and we never set smp_tb_synchronized there.

Hmmm.  Does anyone still have one of those?  I have a dual but not a
quad.

In any case we can use the generic tbsync code (smp-tbsync.c) which
should work on any machine, and doesn't require any hardware support.

Paul.
