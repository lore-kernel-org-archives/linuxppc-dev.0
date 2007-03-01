Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B63F5DDF2F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 10:34:30 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l21NYRFX031739
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2007 18:34:27 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l21NYRiP525568
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2007 16:34:27 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l21NYQOD021297
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2007 16:34:27 -0700
Date: Thu, 1 Mar 2007 17:34:26 -0600
To: Chris Engel <chrisengel@gmail.com>
Subject: Re: [PATCH] spidernet: Fix problem sending IP fragments
Message-ID: <20070301233426.GH4717@austin.ibm.com>
References: <200702281521.34277.n.eicker@fz-juelich.de>
	<1e548a3f0703011452u6dde9c53ifde2fa41fe5f4c38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e548a3f0703011452u6dde9c53ifde2fa41fe5f4c38@mail.gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Norbert Eicker <n.eicker@fz-juelich.de>, netdev@vger.kernel.org,
	Adam Emerich <aemerich@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2007 at 04:52:54PM -0600, Chris Engel wrote:
> I tried to apply this patch to 2.6.21-rc2 and CHECKSUM_HW appears to be
> changed to CHECKSUM_COMPLETE 

The use of CHECKSUM_HW was replaced by CHECKSUM_PARTIAL and CHECKSUM_COMPLETE
on a cae-by-case basis, in the patch series leading up to 2.6.19.  In this case,
I'm not sure which should have been used.

Norbert, can you resubmit a patch that applies to a more recent kernel?
p.s. your emailer replaced tabs by spaces ... 

--linas
