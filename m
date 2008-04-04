Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68860DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 11:17:36 +1100 (EST)
Date: Thu, 3 Apr 2008 19:17:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080404001716.GA18755@ld0162-tx32.am.freescale.net>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<200804031813.59297.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804031813.59297.hollisb@us.ibm.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 06:13:59PM -0500, Hollis Blanchard wrote:
> Stuart, we're getting into ePAPR territory. Do you think we need to worry 
> about a hypervisor not handling mtmsr(MSR_WE)? In that case, we'd need to be 
> more specific than just testing for "/hypervisor". IMHO every hypervisor 
> should implement it... but maybe /hypervisor/idle = "wait" would be more 
> explicit and therefore better?

We can't trap on MSR[WE] updates on hypervisor-enabled chips; the write
is silently ignored.

-Scott
