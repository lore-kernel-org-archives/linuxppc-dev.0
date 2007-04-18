Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CCAFDDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 22:25:29 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3ICPN49004862
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 08:25:23 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3ICPN7a527026
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 08:25:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3ICPNPb007516
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 08:25:23 -0400
Subject: Re: [0/10] Latest Ebony (440GP) support series
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070418063517.GB29312@localhost.localdomain>
References: <20070418063517.GB29312@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 07:23:56 -0500
Message-Id: <1176899036.4373.37.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-18 at 16:35 +1000, David Gibson wrote:
> Aplogies for the truncated series last time around.  Here is my
> current Ebony (440GP) patch series, updated to reflect the pile of
> bootwrapper patches which have been merged into powerpc.git.

FYI for those following the Ebony port.  This patch series still depends
on Ben's arch/powerpc EMAC port.  The latest that I know of can be found
here:

http://gate.crashing.org/~jwboyer/powerpc-emac-new-20070327.diff

josh
