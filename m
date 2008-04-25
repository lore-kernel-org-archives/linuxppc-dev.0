Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0902DE3DA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:48:29 +1000 (EST)
Message-Id: <64466288-A1D3-4567-B01B-E82D99AD89BE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080425081908.4022db0b@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Fri, 25 Apr 2008 08:47:33 -0500
References: <1208789670-28909-1-git-send-email-sr@denx.de>
	<1209104641.9060.228.camel@pasglop>
	<20080425053724.5b3eeb2f@zod.rchland.ibm.com>
	<1209128284.5420.0.camel@pasglop>
	<20080425081908.4022db0b@zod.rchland.ibm.com>
Cc: Stefan Roese <sr@denx.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2008, at 8:19 AM, Josh Boyer wrote:
> On Fri, 25 Apr 2008 22:58:04 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>>
>> On Fri, 2008-04-25 at 05:37 -0500, Josh Boyer wrote:
>>> On Fri, 25 Apr 2008 16:24:01 +1000
>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>
>>>>
>>>> On Mon, 2008-04-21 at 16:54 +0200, Stefan Roese wrote:
>>>>> This patch adds basic endpoint support to the 4xx PCIe driver.
>>>>>
>>>>> This is done by checking the device_type property of the PCIe
>>>>> device node ("pci" for root-complex and "pci-endpoint" for  
>>>>> endpoint
>>>>> configuration).
>>>>>
>>>>> Note: Currently we map a fixed 64MByte window to PLB address 0  
>>>>> (SDRAM).
>>>>> This should probably be configurable via a dts property.
>>>>>
>>>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>>>
>>>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> ---
>>>>
>>>> Paul, I forgot to send that ack a while ago, this is .26  
>>>> material, been
>>>> around for some time.
>>>
>>> I'll add it to my tree.  And this version of the patch was only sent
>>> out on Monday.
>>
>> True but I'm to blame for waiting too long to review it...
>
> Oh, for sure.  We blame you for all kinds of things.  It's just easier
> that way ;)

Can we include an example of the device node in the commit message (or  
some updates to docs/booting-with-of.txt)

- k
