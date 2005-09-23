Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 13EB668338
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 18:24:10 +1000 (EST)
Date: Fri, 23 Sep 2005 01:24:07 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923082407.GA14671@gate.ebshome.net>
References: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<2005922203.qtfGFmWm3E8jkhq1@cisco.com>
	<20050923032236.GA10089@gate.ebshome.net>
	<52irwscq49.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52irwscq49.fsf@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/4] [PPC32] ibm_emac: Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 10:25:26PM -0700, Roland Dreier wrote:
> No problem at all.  Here's a patch against your git tree -- only
> tested on my Yucca board, so you might want to doublecheck that I
> didn't break all the systems will the opposite polarity.

Thanks Roland, I've just pushed your patch with minor style changes 
to my GIT tree.

I changed uint32_t -> u32 and moved emac_phy_done() functions to 
ibm_emac.h. Booted new kernel on Ocotea and everything seems to be OK.

-- 
Eugene
