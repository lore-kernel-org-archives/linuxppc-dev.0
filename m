Return-Path: <SRS0+b070d120c301b1432305+806+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC2B2686C4
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 20:47:38 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17261.57380.473046.69200@cargo.ozlabs.ibm.com>
References: <1131264050.10031.265.camel@baythorne.infradead.org>
	<17261.57380.473046.69200@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 09:47:30 +0000
Message-Id: <1131356850.27347.17.camel@baythorne.infradead.org>
Mime-Version: 1.0
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

On Sun, 2005-11-06 at 21:51 +1100, Paul Mackerras wrote:
> If we really can get unsynchronized timebases still, then I suppose we
> need to bring back the smp_tb_synchronized variable, 

We make no attempt to sync the timebases on quad powersurge, as far as I
can tell -- and we never set smp_tb_synchronized there.

-- 
dwmw2
