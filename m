Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58BE2686AD
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 08:21:15 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131356850.27347.17.camel@baythorne.infradead.org>
References: <1131264050.10031.265.camel@baythorne.infradead.org>
	<17261.57380.473046.69200@cargo.ozlabs.ibm.com>
	<1131356850.27347.17.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 08:20:36 +1100
Message-Id: <1131398436.4652.57.camel@gaston>
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

On Mon, 2005-11-07 at 09:47 +0000, David Woodhouse wrote:
> On Sun, 2005-11-06 at 21:51 +1100, Paul Mackerras wrote:
> > If we really can get unsynchronized timebases still, then I suppose we
> > need to bring back the smp_tb_synchronized variable, 
> 
> We make no attempt to sync the timebases on quad powersurge, as far as I
> can tell -- and we never set smp_tb_synchronized there.

We don't even use the software sync ? Hrm... actually, I think the
software sync was designed for 2 CPUs only.

Now, go find the one user that had a quad powersurge :)

Ben.
