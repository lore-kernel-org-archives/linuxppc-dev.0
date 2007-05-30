Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 218CDDDF10
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:18:08 +1000 (EST)
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1180466979.3360.69.camel@zod.rchland.ibm.com>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
	<a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
	<1180466979.3360.69.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:17:15 +1000
Message-Id: <1180523835.19517.245.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 14:29 -0500, Josh Boyer wrote:
> 
> *shrug*  Either way works for me.
> 
> We're adding these compatible properties to DTS files and the drivers
> at
> the same time.  Unless (until?) there are firmwares for these boards
> that start specifying something else in a real device tree, it really
> doesn't matter much.  Not that there's anything wrong with your
> reasoning.  Just seems like we're trying really hard to define
> something
> "correctly" when we control what's on both sides :).
> 

I do think Segher is right there... compatible 109 and then 108

Ben.
