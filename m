Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E8E0DDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 06:59:53 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1166538553.25827.99.camel@pmac.infradead.org>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166522096.25827.76.camel@pmac.infradead.org>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 06:58:19 +1100
Message-Id: <1166558300.19254.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	Paul Mackerras <paulus@samba.org>, bbrv@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> OK, let's drop the patch and assume the device-tree will be fixed
> shortly. 

No, keep the patch for now. I'm afraid they aren't willing to fix their
device-tree.

> In the meantime, users should be able to work around it by
> hacking the device-tree from the OF prompt -- which we currently have to
> do for other things in the Efika device-tree anyway.
> 
> I'm happy enough for Fedora to require the fixed firmware, certainly. 
> 
