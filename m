Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65612DDE38
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 20:38:13 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48Ac8AO011839
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 06:38:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48Ac747160008
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 04:38:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48Ac76H008509
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 04:38:07 -0600
Date: Tue, 8 May 2007 05:46:40 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: Re: [PATCH v4 0/7] Add support for 750CL Holly board
Message-ID: <20070508104640.GM23995@crusty.rchland.ibm.com>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E753A11@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E753A11@zch01exm23.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 11:45:05AM +0800, Zang Roy-r61911 wrote:
> > 
> > Hi All,
> > 
> > This is round 4 of the patches to support the 750CL Holly board, and
> > hopefully the last.  They also fix one of the PCI issues I was seeing.
> Sorry, Maybe I missed your previous comment.
> What is the PCI issue? Associated with your board or tsi108/9 ?

Mostly it was the fact that PIBS (the low level boot firmware) setup the PCI
bridge in an odd fashion.  The other small issue was that the TSI PCI bridge
was not being designated as the primary.  Both of these were found working
with a developer from Tundra.

josh
