Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C3C0DDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 08:45:58 +1000 (EST)
In-Reply-To: <1183150190.22547.62.camel@farscape.rchland.ibm.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<20070625235032.GH9768@bakeyournoodle.com>
	<1183149584.22547.51.camel@farscape.rchland.ibm.com>
	<1183150190.22547.62.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5204a94ef7649d5ebc72df2eb93db6e0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2.1 ] Fix VDSO gettimeofday() when called with NULL
	struct timeval.
Date: Sat, 30 Jun 2007 00:45:47 +0200
To: will_schmidt@vnet.ibm.com
Cc: willschm@linux.vnet.ibm.com, LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The vdso64 portion of patch 74609f4536f2b8fd6a48381bbbe3cd37da20a527 
> for
> fixing problems with NULL gettimeofday input mistakenly checks for a
> null tz field twice, when it should be checking for null tz once, and
> null tv once; by way of a r10/r11 typo.
>
> Any application calling gettimeofday(&tv,NULL) will "fail".
>
> This corrects that typo, and makes my G5 happy.
>
> tested on G5.
>
>
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

Obviously correct, how could we all have missed this :-(

Thanks Will.


Segher
