Return-Path: <nhorman@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id BCDE7B70AB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 23:01:10 +1000 (EST)
Date: Thu, 5 Aug 2010 09:00:59 -0400
From: Neil Horman <nhorman@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add vmcoreinfo symbols to allow makdumpfile to
	filter core files properly
Message-ID: <20100805130059.GA2863@shamino.rdu.redhat.com>
References: <20100713134609.GA14514@hmsreliant.think-freely.org>
	<20100804144929.GA13970@hmsreliant.think-freely.org>
	<1280973866.1902.168.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280973866.1902.168.camel@pasglop>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, vgoyal@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 05, 2010 at 12:04:26PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-08-04 at 10:49 -0400, Neil Horman wrote:
> > Ping yet again. Ben, This needs review/acceptance from you or Paul
> > Neil 
> 
> Isn't it already in powerpc-next about to be pulled by Linus ?
> 
Yes, there it is.  Apologies.  For whatever reason, I was looking on the main
branch of your tree.  It didn't occur to me to check your next branch.  Sorry.

> In general, I recommend you check the status of your patches on
> patchwork. I'm nagging Jeremy to add a feature so it emails the
> submitter when the patch status changes :-)
> 
Noted, I'll remember that.  Email from patchwork would be a nice feature. +1
from me. 

Thanks & Regards
Neil

> Cheers,
> Ben.
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
