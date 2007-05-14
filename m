Return-Path: <boutcher@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B7CEDDEC4
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:54:45 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4DNqsas019657
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 19:52:54 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4E0sevi534172
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 20:54:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4E0se8k028764
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 20:54:40 -0400
In-Reply-To: <20070513155027.GB9218@lst.de>
To: Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Subject: Re: [PATCH] viopath: use completion
From: David Boutcher <boutcher@us.ibm.com>
Message-ID: <OF8C264148.56AEB7C2-ON862572DB.00045715-862572DB.0005010E@us.ibm.com>
Date: Sun, 13 May 2007 19:54:39 -0500
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig <hch@lst.de> wrote on 05/13/2007 10:50:27 AM:
> Use a completion instead of abusing a semaphore for hypervisor event
> completion in viopath.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Not that my ack is terribly relevant any more, but

Acked-by: Dave Boutcher <boutcher@us.ibm.com>

Dave B
