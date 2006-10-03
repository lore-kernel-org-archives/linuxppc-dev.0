Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 807CD67C2B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:30:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k93IUL39006476
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 11:30:22 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k93IUKLH029881
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 13:30:21 -0500 (CDT)
Subject: Re: [RFC][PATCH 1/2] remove mpc83xx support from arch/ppc
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <229C6ACA-4728-408B-9360-54249996E821@kernel.crashing.org>
References: <20060928160211.5b652932.kim.phillips@freescale.com>
	<229C6ACA-4728-408B-9360-54249996E821@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1159899616.14294.127.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 03 Oct 2006 13:20:17 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-28 at 16:34, Kumar Gala wrote:
> On Sep 28, 2006, at 4:02 PM, Kim Phillips wrote:
> 
> > remove 83xx support from arch/ppc.  Tested multiple arch/defconfig  
> > build combinations ok.  AFAICT, everything 83xx works in arch/ 
> > powerpc, and new derivatives are being added only to arch/powerpc,  
> > so it's better not to keep this around.
> 
> NACK!! we need the cuImage stuff working and in the tree before I'm  
> ok with this.  We have to be able to boot from a non-flat-dev aware u- 
> boot before I'll be ok with removing 83xx from arch/ppc.
> 
> - kumar

Any idea when those patches are going to be in?

Thanks,
jdl
