Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 405E8DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 05:19:49 +1100 (EST)
Date: Thu, 19 Mar 2009 21:19:48 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH -next] gianfar, ucc_geth: Use proper address
	translation for MDIO buses
Message-ID: <20090319181948.GA9360@oksana.dev.rtsoft.ru>
References: <20090318192152.GA29621@oksana.dev.rtsoft.ru>
	<A41D3E28-93C8-46FD-A87A-EDE6C4D4E77B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <A41D3E28-93C8-46FD-A87A-EDE6C4D4E77B@kernel.crashing.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>,
	Scott Wood <scottwood@freescale.com>, Li Yang <leoli@freescale.com>,
	David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 03:57:10AM -0500, Kumar Gala wrote:
> On Mar 18, 2009, at 2:21 PM, Anton Vorontsov wrote:
[...]
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>
>> This is for 2.6.30 since we don't use ranges = <> yet.
>>
>> David, I believe Kumar would like to pick this patch into his tree
>> along with a patch set that adds "ranges = <>" properties to the
>> device tree... So would you mind if we take it via powerpc.git?
>>
>> Thanks,
>>
>> drivers/net/gianfar_mii.c  |   10 +++++++---
>> drivers/net/ucc_geth_mii.c |   10 +++++++---
>> 2 files changed, 14 insertions(+), 6 deletions(-)
>
> Andy merged these in net-next to just have drivers/net/fsl_pq_mdio.c.
>
> My suggestion is to update the patch against -next and have David put it 
> into net-next.
>
> (I'll deal w/the .dts updates in powerpc.git and cherry pick commits out 
> of net-next into my testing branching)

Btw, if we want some testing for .dts changes, you could just merge
this patch into your powerpc.git tree along with other patches, and
then, when merge window opens, just fix a trivial conflict in
{ucc_geth,gianfar}_mii.c files (i.e. just remove the files).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
