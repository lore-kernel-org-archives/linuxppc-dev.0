Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 79D8E67B54
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 11:46:18 +1000 (EST)
Message-ID: <452C4CE0.5010607@am.sony.com>
Date: Tue, 10 Oct 2006 18:46:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: jschopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
References: <20061010204946.GW4381@austin.ibm.com>	<20061010212324.GR4381@austin.ibm.com>
	<452C2AAA.5070001@austin.ibm.com>
In-Reply-To: <452C2AAA.5070001@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: akpm@osdl.org, jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

jschopp wrote:
> Linas Vepstas wrote:
>> The current driver code performs 512 DMA mappns of a bunch of 
>> 32-byte structures. This is silly, as they are all in contiguous 
>> memory. Ths patch changes the code to DMA map the entie area
>> with just one call.
>> 
>> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>> Cc: James K Lewis <jklewis@us.ibm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> The others look good, but this one complicates the code and doesn't have any benefit.  20 
> for 21 isn't bad.

Linas, 

Is the motivation for this change to improve performance by reducing the overhead
of the mapping calls?  If so, there may be some benefit for some systems.  Could
you please elaborate?

-Geoff
