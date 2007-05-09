Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06A6DDDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 07:42:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49Lgb0Z024725
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 17:42:37 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49Lgcos508734
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 17:42:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49Lgb36027985
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 17:42:37 -0400
Date: Wed, 9 May 2007 16:42:36 -0500
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] powerpc: export pcibios_remove_pci_devices()
Message-ID: <20070509214236.GB4452@austin.ibm.com>
References: <1178743853.22467.13.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178743853.22467.13.camel@sinatra.austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 09, 2007 at 03:50:53PM -0500, John Rose wrote:
> The rpadlpar_io module depends on this.

I sent this a few days ago, it should already be in orvlads git tree by
now ... 
