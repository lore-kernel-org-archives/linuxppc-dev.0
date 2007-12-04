Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 639D9DE0A7
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:36:09 +1100 (EST)
Date: Tue, 4 Dec 2007 14:40:11 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] [POWERPC] MPC8349E-mITX: introduce localbus and
	pata nodes
Message-ID: <20071204204011.GB8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170726.GC15599@localhost.localdomain>
	<20071204191657.GB5758@lixom.net>
	<20071204194531.GA1253@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204194531.GA1253@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 10:45:31PM +0300, Anton Vorontsov wrote:
> This patch adds localbus and pata nodes to use CF IDE interface
> on MPC8349E-mITX boards.
> 
> Patch also adds code to probe localbus.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
