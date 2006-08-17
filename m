Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23CC667B5C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 09:35:14 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7HNYfGc002616
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 19:34:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7HNYfUo373402
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 17:34:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7HNYfoE020137
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 17:34:41 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/13] IB/ehca: makefiles/kconfig
Date: Fri, 18 Aug 2006 01:34:37 +0200
References: <20068171311.WDFBWw0F6z9B3Qes@cisco.com>
In-Reply-To: <20068171311.WDFBWw0F6z9B3Qes@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608180134.39050.arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, RAISCH@de.ibm.com,
	HNGUYEN@de.ibm.com, MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 August 2006 22:11, Roland Dreier wrote:
> +
> +CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL

This seems really pointless, since you're always defining these
macros to the same value.

Just drop the CFLAGS and remove the code that depends on them
being different.

	Arnd <><
