Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17138.37976.125149.720836@cargo.ozlabs.ibm.com>
Date: Fri, 5 Aug 2005 08:19:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050803221517.21b54d7e.akpm@osdl.org>
References: <20050802095509.GA32585@lst.de>
	<20050803221517.21b54d7e.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix gcc4 warning in asm-ppc/time.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> Do we really want to do this?  The above implies that mfspr(SPRN_PVR) will
> return the same value across the entire uptime of the kernel.  Is that
> true?

Yes, the PVR is the processor version register, and it would be quite
disturbing if the silicon changed underneath us. :)

> Why is this function paying with const anyway?

It seemed like a good idea at the time? :)

Paul.
