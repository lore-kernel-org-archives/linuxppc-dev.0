Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22A6667B22
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 06:44:44 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA1JifOW021356
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 14:44:41 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA1Jif25465688
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 12:44:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA1JifsA021006
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 12:44:41 -0700
Subject: Re: powerpc: "unable to handle .. paging request" during IPR probe
From: John Rose <johnrose@austin.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1162408093.18733.6.camel@zod.rchland.ibm.com>
References: <1162407611.28335.27.camel@sinatra.austin.ibm.com>
	<1162408093.18733.6.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Message-Id: <1162410309.28335.29.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 01 Nov 2006 13:45:10 -0600
Cc: External List <linuxppc-dev@ozlabs.org>, Brian King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think so.  Try changing module_init(ata_init) to subsys_init(ata_init)
> in drivers/ata/libata-core.c

I gave it a try, but still seeing the same crash :(  Have you observed
this fix working?

Thanks-
John
