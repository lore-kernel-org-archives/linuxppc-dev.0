Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75F1E682FA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:32:59 +1000 (EST)
Date: Thu, 22 Sep 2005 20:32:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923033257.GC10089@gate.ebshome.net>
References: <2005922203.qtfGFmWm3E8jkhq1@cisco.com>
	<2005922203.tCj2DaX4oc1ISyYc@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2005922203.tCj2DaX4oc1ISyYc@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 4/4] [PPC32] Add Yucca (440SPe eval board) platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 08:03:35PM -0700, Roland Dreier wrote:
> Add support for AMCC PowerPC 440SPe "Yucca" eval board platform.

[snip]

> +/*
> + * This is a horrible kludge, we eventually need to abstract this
> + * generic PHY stuff, so the  standard phy mode defines can be
> + * easily used from arch code.
> + */
> +#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"

This is not needed anymore. Please, remove this.

-- 
Eugene
