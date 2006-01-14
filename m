Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1A977681BD
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jan 2006 10:47:57 +1100 (EST)
Date: Sat, 14 Jan 2006 15:47:54 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Add FSL SOC library and setup code
Message-ID: <20060114234754.GB29766@gate.ebshome.net>
References: <Pine.LNX.4.44.0601131118350.19371-100000@gate.crashing.org>
	<20060114192158.GS2491@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060114192158.GS2491@pb15.lixom.net>
Cc: Kumar Gala <galak@gate.crashing.org>, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 14, 2006 at 01:21:58PM -0600, Olof Johansson wrote:
> > +
> > +static phys_addr_t immrbase = -1;
> 
> What does immr mean? Maybe a short comment would be good.

IMHO, this is not needed because _everybody_ who is working 
with these chips know what IMMR means. And there cannot be _any_ 
confusion about it. Let's not add useless comments.

We don't add comments describing what MMU, PTE, PCI and IOMMU means, 
do we? Any chip specific code has tons of strange abbreviations 
which might be puzzling for anybody who isn't familiar with this chip 
but are quite clear for anybody who are.

-- 
Eugene
