Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 60A7ADE140
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 00:52:21 +1100 (EST)
Message-ID: <47EBA616.9070705@ru.mvista.com>
Date: Thu, 27 Mar 2008 16:50:14 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
References: <20080306134359.GA31762@ru.mvista.com>	<1206400935.7197.59.camel@pasglop>
	<20080326073554.1d8229d6@zod.rchland.ibm.com>
In-Reply-To: <20080326073554.1d8229d6@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, 25 Mar 2008 10:22:15 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>> On Thu, 2008-03-06 at 16:43 +0300, Valentine Barshak wrote:
>>> This patch adds ibm_newemac PHY clock workaround for 440EP/440GR EMAC
>>> attached to a PHY which doesn't generate RX clock if there is no link.
>>> The code is based on the previous ibm_emac driver stuff. The 440EP/440GR
>>> allows controlling each EMAC clock separately as opposed to global clock
>>> selection for 440GX.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This never went to netdev or Jeff from what I can see.
> 
> josh

Do I need to resend these and the other one from 
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052114.html 
cc'ing Jeff?

I thought it was decided that Ben collects and sends all emac patches to 
netdev.

Thanks,
Valentine.
