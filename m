Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 43B1F67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:40:37 +1000 (EST)
Date: Fri, 8 Apr 2005 11:39:42 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ho Lee <flylist@linuxkernel.net>
Message-ID: <20050408113942.A25938@cox.net>
References: <F38DEABE0E171746B133C1ABBD142D9703691AFD@radmail.Radstone.Local>
	<013c01c53c63$8b4e98e0$0d02a8c0@acting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <013c01c53c63$8b4e98e0$0d02a8c0@acting>;
	from flylist@linuxkernel.net on Fri, Apr 08, 2005 at 10:51:05AM
	-0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MTD Mapping driver - out of vmalloc space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 10:51:05AM -0700, Ho Lee wrote:
> 
> Hi Chris,
> 
> How about setting PAGE_OFFSET to 0x80000000, that is 2G/2G split?
> It would make enough virtual address space. I've never tried on PPC,
> so I don't know the side effect of this. 

This is the ideal solution.  It works fine with the caveat that
you have to be very aware of the virtual memory map of your board
port when doing this.  On ppc32, we have very fine grained options
for manipulating this and other parameters under Advanced Options.
If the original poster can provide more details then we can tell
him the exact settings to use.

-Matt
