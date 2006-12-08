Return-Path: <anton@ozlabs.org>
Date: Fri, 8 Dec 2006 16:41:06 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Add DSCR SPR to sysfs
Message-ID: <20061208054106.GB9391@krispykreme>
References: <20061206205818.GA27857@krispykreme>
	<17784.62591.729512.791358@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17784.62591.729512.791358@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> I think you need to adjust both CPU_FTRS_POWER6 and CPU_FTRS_POWER6X
> in include/asm-powerpc/cputable.h, don't you?

Oops, totally forgot about that madness :) New patch on the way.

Anton
