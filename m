Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8694DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 13:55:45 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4G3tfMb018227
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 23:55:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4G3tfQl144170
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 23:55:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4G3tf4A019737
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 23:55:41 -0400
Date: Thu, 15 May 2008 22:52:21 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH] 4xx: Fix PCI mem in rainier DTS
Message-ID: <20080515225221.277c8ce4@zod.rchland.ibm.com>
In-Reply-To: <20080516001529.GB11402@yookeroo.seuss>
References: <20080515094123.44974e84@zod.rchland.ibm.com>
	<20080516001529.GB11402@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008 10:15:29 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> On Thu, May 15, 2008 at 09:41:23AM -0500, Josh Boyer wrote:
> > This fixes the PCI node in the Rainier to match the spec from AMCC.  A
> > similar fix was done for 440EPx, which shares the same values as 440GRx.
> 
> This will conflict with the dts-v1 conversion patch.

I'm well aware of that.  It will be fixed up.  Thanks.

josh
