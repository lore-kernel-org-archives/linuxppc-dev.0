Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 020E467B56
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 07:16:21 +1000 (EST)
Subject: Re: Linux v2.6.18-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1152537672.28828.4.camel@farscape.rchland.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
	<1152537672.28828.4.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:16:11 +1000
Message-Id: <1152566171.1576.98.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-10 at 08:21 -0500, Will Schmidt wrote:
> On Sun, 2006-09-07 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > > We've got a ppc64 machine that won't boot with this due to an IDE error.
> > 
> > What machine precisely ?
> 
> I see a slightly more verbose version on a JS20 blade. 

Can you try with the new patches I posted yesterday ?

Ben.
