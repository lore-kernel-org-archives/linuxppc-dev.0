Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E76522BDB8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 04:40:24 +1000 (EST)
In-Reply-To: <1097515329.8508.66.camel@nighteyes.localdomain>
References: <1097515329.8508.66.camel@nighteyes.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <547E0D34-1BB5-11D9-909B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 11 Oct 2004 14:42:40 -0400
To: Jeff Angielski <jangiels@speakeasy.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Creating rootfs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 11, 2004, at 1:22 PM, Jeff Angielski wrote:

> So how are people creating the rootfs for their embedded target these
> days?  Busybox?  PTX?  Strip down some existing filesystem?

Those are the solutions, choose whatever works best for you.
Some commercial distributions have tools for creating a file
system that meets the requirements of the applications.

> I have an opportunity to start "fresh" with our current rootfs and 
> could
> not find anything definitive when google-ing for solutions.

The methods are as you described above.  The results are as
varied as the embedded systems upon which they are used.


	-- Dan
