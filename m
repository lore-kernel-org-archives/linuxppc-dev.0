Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A973DDEE3
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 06:01:48 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4HK1hWh032380
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 16:01:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4HK1hEe250088
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 14:01:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4HK1gkt020403
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 14:01:43 -0600
Subject: Re: [PATCH] fix 440-related Kconfig warnings
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070517132434.GA26230@lst.de>
References: <20070517132434.GA26230@lst.de>
Content-Type: text/plain
Date: Thu, 17 May 2007 15:00:41 -0500
Message-Id: <1179432041.9870.6.camel@zod.rchland.ibm.com>
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

On Thu, 2007-05-17 at 15:24 +0200, Christoph Hellwig wrote:
> Currently there is no IBM_NEW_EMAC_ZMII in the tree, so we shouldn't 
> selected it.
> 

Someone else already submitted a patch for this last week, but yours is
more complete.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
