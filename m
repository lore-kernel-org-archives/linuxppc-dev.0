Return-Path: <kelsey@codemonkey.net>
Received: from z.codemonkey.net (z.codemonkey.net [64.142.120.45])
	by ozlabs.org (Postfix) with ESMTP id D8A14DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Jan 2007 08:46:52 +1100 (EST)
Date: Mon, 8 Jan 2007 15:13:06 -0600
From: Kelsey Dawes <kelsey@codemonkey.net>
To: onetarget@sina.com
Subject: Re: how to build cross-compiling toolchains for PowerPC?
Message-ID: <20070108211306.GC17617@nimrod.unx.ca>
References: <20070108020624.52998.qmail@mail3-101.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070108020624.52998.qmail@mail3-101.sinamail.sina.com.cn>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jan 08, 2007 at 10:06:24AM +0800, onetarget@sina.com wrote:
> 
Dear all
    I want to build a complete cross-compiling
toolchains for PowerPC, the kernel I want to build is linux-2.4.25, the
host is FC4's PC, and I also want to use glibc-2.3.6, so with all
above, which gcc, glibc,binutils should I use? And what is the step
should I do?
    Thank you all and best regards,
    W.Target
    Jan-8-2007
> 

Haven't played with any of your specific requirements as noted  above; however in the past, I've had good luck using Dan Kegel's crosstool software

www.kegel.com/crosstool

It does require a bit of trial and error to get right.

Kelsey 
