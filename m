Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5B7067A03
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2005 17:46:48 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
References: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 20 May 2005 17:45:14 +1000
Message-Id: <1116575115.5153.115.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu type explicitly, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-05-20 at 16:05 +1000, Paul Mackerras wrote:
> Here is a revised version of my patch to set the cpu type explicitly
> for gcc when compiling the kernel.  Setting the cpu type is a good
> idea in any case, and particularly if you have a biarch gcc.  This
> sets the type for all of the ppc cpu families we support.
> 
> Any further comments?  Are -mcpu=860 and -mcpu=8540 reasonable for 8xx
> and 85xx respectively?  I used -mcpu=power4 rather than -mcpu=970
> because the former works with gcc-3.6.6 as in debian and the latter
> doesn't.  Unfortunately -mcpu=440 doesn't work either in gcc 3.3,
> though it does in gcc 3.4 (as does -mcpu=970).

The problem is the same as ppc64 isn't it ?, -maltivec doesn't work with
-mcpu=power4 on gcc 3.4 does it ? That would mean no RAID6...

Ben.
