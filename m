Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62A24DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 23:06:10 +1000 (EST)
Subject: Re: Fix small race in 44x tlbie function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20070809120450.GE3925@crusty.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
	<57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
	<20070809120450.GE3925@crusty.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 23:05:36 +1000
Message-Id: <1186664737.481.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Volkmar Uhlig <vuhlig@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Todd Inglett <tinglett@us.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-09 at 07:04 -0500, Josh Boyer wrote:
> 
> > We don't have critical wired to anything, I don't expect watchdog
> to  
> > cause another fault.. so just wondering.
> 
> We being who?  I'm slightly confused here. 

I think Kumar doesn't know that we are talking about the BG kernel which
has more things "wired" to CRIT than what is upstream at the moment :-)

Ben.
