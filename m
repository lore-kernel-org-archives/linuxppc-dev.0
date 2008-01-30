Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1594EDDE9A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 11:58:10 +1100 (EST)
Date: Tue, 29 Jan 2008 18:58:10 -0600
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8] Cell IOMMU fixed mapping support
Message-ID: <20080130005810.GB32622@lixom.net>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1201619625.10012.19.camel@concordia>
	<20080129155048.GA19822@lixom.net>
	<200801300154.02358.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200801300154.02358.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 01:54:01AM +0100, Arnd Bergmann wrote:

> I don't see how it should be possible here to reuse the 2-4GB range
> for anything else.

Right, that was obvious after Ben's reply as well. Michael's description
made me think the linear mapping was at bus address 2G when it wasn't.


-Olof
