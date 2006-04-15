Return-Path: <jdmason@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB8B5679E6
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 00:34:38 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3FDYGlF016881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 09:34:17 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3FDY2xC002564
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 09:34:02 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3FDUTTk248524
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 07:30:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3FDY2ua026962
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 07:34:02 -0600
Date: Sat, 15 Apr 2006 08:37:52 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
Message-ID: <20060415133752.GB7712@us.ibm.com>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<20060413173121.GJ10412@granada.merseine.nu>
	<1144961564.4935.24.camel@localhost.localdomain>
	<20060414144830.GQ10412@granada.merseine.nu>
	<1145048275.4223.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145048275.4223.32.camel@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 15, 2006 at 06:57:55AM +1000, Benjamin Herrenschmidt wrote:
> 
> > What I had in mind is an interface that given a PCI bridge will tell
> > you what's the most restrictive DMA mask for a device on that bridge,
> > so that you'll know whether you need to enable the IOMMU for that
> > bridge. I'll even settle for a function that tells you what's the most
> > restrictive DMA mask in the system, period. There's nothing inherently
> > arch specific about this.
> >
> > (and as a side note, the IOMMU we are working on on x86-64 is Calgary,
> > which is actually roughly the same chipset used in some PPC
> > machines...)
> 
> Not sure I ever heard about that... What chipsets ?

The pSeries POWER4 based systems (Regatta) had Calgary, and the 
RS/6000 POWER3 based systems (Condor) had Winnipeg (a precursor to
Calgary, with many of the same features).

Thanks,
Jon

> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
