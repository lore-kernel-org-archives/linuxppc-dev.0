Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 2834367AC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 01:55:08 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 23 Feb 2005 15:54:56 +0100
References: <4219EC67.1070602@dgt-lab.com.pl>
In-Reply-To: <4219EC67.1070602@dgt-lab.com.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502231554.56860.g.jaeger@sysgo.com>
Cc: Wojciech Kromer <krom@dgt-lab.com.pl>
Subject: Re: any hints using gcc 3.4.3 for 2.4.25 kernel?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 21 February 2005 15:12, Wojciech Kromer wrote:
> a)first i have:
> - 2.4.25 kernel (from denx cvs)
> - eldk with 2.95.4 compiler
> this one set works fine :)
> 
> b)then, i've tried  to same sources with:
> gcc-3.4.3 , self build from uClibc buildroot
> new hernel hangs just after decompressing :(
> 
> any tricks?
> 

you can use the include/linux/init.h and compiler.h from 2.4.29
kernel + patching some header files, where the inlining does not
work any longer. I also suggest comparing with 2.4.29 kernel.

ciao,
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
