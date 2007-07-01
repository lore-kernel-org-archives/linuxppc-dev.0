Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68A7FDDF09
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jul 2007 12:04:17 +1000 (EST)
Subject: Re: difference between ppc and powerpc
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: silicom <silicom@163.com>
In-Reply-To: <25584182.1710331183250229848.JavaMail.coremail@bj163app48.163.com>
References: <25584182.1710331183250229848.JavaMail.coremail@bj163app48.163.com>
Content-Type: text/plain
Date: Sat, 30 Jun 2007 20:05:32 -0500
Message-Id: <1183251933.10368.7.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
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

On Sun, 2007-07-01 at 08:37 +0800, silicom wrote:
> Hi
>   Can anybody tell me the difference between arch->ppc and
> arch->powerpc?

arch/ppc is the original tree for 32 bit PowerPC machines.  arch/powerpc
is the merged tree for both 32 and 64 bit PowerPC machines.  arch/ppc is
dying a slow death and really shouldn't be used for new submissions.

josh
