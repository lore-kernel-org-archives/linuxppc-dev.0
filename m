Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 081A367B21
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 19:11:01 +1000 (EST)
Subject: Re: Please pull from 'for_paulus' branch of powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BDF5A6D5-E7F4-4CDF-9B34-13A66A0B7C99@kernel.crashing.org>
References: <9FCDBA58F226D911B202000BDBAD467306E19B76@zch01exm40.ap.freescale.net>
	<BDF5A6D5-E7F4-4CDF-9B34-13A66A0B7C99@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 19:10:52 +1000
Message-Id: <1151572252.28229.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Even though other 86xx platforms have no these PCI chips, these  
> > codes will not take effect.
> 
> Its code bloat for systems that dont need it.

Well... it depends :) If it's totally unlikely to ever have this chip in
those platforms, then yes. But if it's common enough, it's fair to have
the quirk in a generic place (provided that Whang is right and the fixup
is indeed the same for all 86xx platforms)

Ben.
