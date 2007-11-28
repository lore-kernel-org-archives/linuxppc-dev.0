Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BBC11DE115
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 06:54:10 +1100 (EST)
Date: Wed, 28 Nov 2007 11:47:27 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [PPC 44x] enable L2-cache for ALPR, Katmai,
	Ocotea, and Taishan
Message-ID: <20071128194727.GA22325@gate.ebshome.net>
References: <1416528026.20071107014041@emcraft.com>
	<1196120506.7157.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196120506.7157.18.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 10:41:46AM +1100, Benjamin Herrenschmidt wrote:
> BTW... Do you know why we can't just enable HW snoop ? The 440SPe
> documentation seems to indicate that this is supported by the L2 cache
> via snooping on the PLB.

Unless something has been changed significantly in the 44x port, but 
L2 cache code I wrote for 440GX did exactly this - we never needed any 
manual L2 cache management at all.

-- 
Eugene
