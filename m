Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C3DD2BDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2004 06:08:41 +1100 (EST)
Date: Fri, 26 Nov 2004 20:07:54 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041126200754.1123e8f8@jack.colino.net>
In-Reply-To: <1101439228.4633.74.camel@gaston>
References: <1101439228.4633.74.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "David S. Miller" <davem@redhat.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sungem rework & wake on lan
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 26 Nov 2004 at 14h11, Benjamin Herrenschmidt wrote:

Hi Ben, 

 	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
-		gp->phy_mii.def->ops->suspend(&gp->phy_mii, 0 /* wake on lan options */);
+		gp->phy_mii.def->ops->suspend(&gp->phy_mii);

Shouldn't this if() have an "&& !wol" clause ?
At least it doesn't work without it, and works with it, here on 5221 PHY.

Thanks for your work. Will post a patch applying to 2.6.9+sleep_patch soon 
for the possibly interested people.

-- 
Colin
  http://www.colino.net/
