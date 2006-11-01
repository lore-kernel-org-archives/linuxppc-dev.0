Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0076967B5B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 06:08:24 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA1J8MXJ031652
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 14:08:22 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA1J8L0e236534
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 12:08:21 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA1J8KDi002674
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 12:08:20 -0700
Subject: Re: powerpc: "unable to handle .. paging request" during IPR probe
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Rose <johnrose@austin.ibm.com>
In-Reply-To: <1162407611.28335.27.camel@sinatra.austin.ibm.com>
References: <1162407611.28335.27.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 13:08:12 -0600
Message-Id: <1162408093.18733.6.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: External List <linuxppc-dev@ozlabs.org>, Brian King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-01 at 13:00 -0600, John Rose wrote:
> Anyone else seen this crash during boot on pseries?  This is 2.6.19-rc4
> with 4k pages.

I think so.  Try changing module_init(ata_init) to subsys_init(ata_init)
in drivers/ata/libata-core.c

josh
