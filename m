Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AD4BB67D1D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:16:47 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB7HGWcj006768
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 12:16:32 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB7HGVxB485078
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 10:16:31 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB7HGV6f014895
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 10:16:31 -0700
Date: Thu, 7 Dec 2006 11:16:30 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/16] Spidernet DMA coalescing
Message-ID: <20061207171630.GA4614@austin.ibm.com>
References: <20061206223223.GH17931@austin.ibm.com>
	<20061206232745.GA4649@austin.ibm.com>
	<20061206230847.dfd7cb18.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061206230847.dfd7cb18.akpm@osdl.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	jgarzik@pobox.com, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 06, 2006 at 11:08:47PM -0800, Andrew Morton wrote:
> 
> It worries me when a patch series gets resent a few hours later.
> 
> Did anything change?

I did not resend this patch series.  However, I did receive a large 
number of MTA errors:
   <linuxppc-dev@ozlabs.org>: mail forwarding loop for linuxppc-dev@ozlabs.org

which might be related to what you saw.

(I also cc'ed several lists, and delivry on one of the lists may have
been delayed by a few hours??)

--linas
