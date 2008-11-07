Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C627FDDEF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 09:37:38 +1100 (EST)
In-Reply-To: <4914C0FB.60101@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OF2FC25006.EFC05820-ON882574FA.007C35D8-882574FA.007C3C11@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 7 Nov 2008 14:37:13 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> There's some network stuff that uses it for optimization.  If 
> CONFIG_NET_DMA is
> enabled, that will turn on some kind of TCP/IP offloading.  I don't 
> really know
> much about that.  There's also a dmatest.c testing driver.
> 
> It would definitely be nice to see a third client driver.
> 

I'll see what I can do :).  Thanks for the help.

Bruce
