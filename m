Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34BF6DE56F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 04:38:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3OIc97l005932
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 14:38:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3OIc94r195296
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 12:38:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3OIc8Li015879
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 12:38:08 -0600
Subject: Re: [PATCH] [POWERPC] bootwrapper: fix build error on virtex405-head.S
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080424173246.17691.73308.stgit@trillian.secretlab.ca>
References: <20080424173246.17691.73308.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 13:38:07 -0500
Message-Id: <1209062287.4944.5.camel@weaponx>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-24 at 11:33 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> virtex405-head.S is an assembler file, not a C file; therefore BOOTAFLAGS
> is the correct place to set the needed -mcpu=405 flag.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Applied, pushed to 4xx/next and 4xx/for-2.6.26, and included in my pull
request.

josh
