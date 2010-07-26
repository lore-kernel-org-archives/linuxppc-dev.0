Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C9696B70E8
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 08:48:38 +1000 (EST)
Date: Mon, 26 Jul 2010 15:48:54 -0700 (PDT)
Message-Id: <20100726.154854.35052662.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
	of_node_to_nid()
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
References: <20100726220405.1550.63442.stgit@angua>
	<20100726222627.GA23501@merkur.ravnborg.org>
	<AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 16:42:20 -0600

> It protects against some later include file doing a #define
> of_node_to_nid and thus resulting in an inconsistent definition.  If
> some code tries to do this then the preprocessor will complain.  This
> is the pattern that Stephen suggested.

Also, it would be nice to unravel the "0" vs. "-1" default
inconsistency.
