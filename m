Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 305441007E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:22:28 +1100 (EST)
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake
	ram 	regions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0C1337.6070309@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
	<4B0AED90.6050600@yahoo.es> <1259019909.31172.63.camel@concordia>
	<4B0C1337.6070309@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 16:22:19 +1100
Message-ID: <1259212939.16367.272.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-24 at 18:09 +0100, Albert Herranz wrote:
> I could use ppc_md.ioremap to duplicate ioremap except for the ioremap
> ram check.
> But calling the stock ioremap without modifying it is not possible
> because it checks and bails out when ioremapping a region marked as
> ram (even if it's not real ram and it's memreserved).
> 
> Is the list of memreserved areas preserved once the kernel is running?
> If it is preserved another option would be to unban ioremapping ram if
> memreserved.

Yes, check lmb's they should still be around.

Cheers,
Ben.
