Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E884DDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 23:13:09 +1100 (EST)
Message-ID: <47A9A443.2020109@pobox.com>
Date: Wed, 06 Feb 2008 07:12:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii matching
	table
References: <1200476230-14026-1-git-send-email-sr@denx.de>
	<1200477239.6755.21.camel@pasglop>
	<20080116090110.1b7b2f00@zod.rchland.ibm.com>
	<200801300716.52463.sr@denx.de> <1201734898.8146.0.camel@pasglop>
	<20080205151216.4ff3c32a@weaponx>
In-Reply-To: <20080205151216.4ff3c32a@weaponx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stefan Roese <sr@denx.de>, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 31 Jan 2008 10:14:58 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>> On Wed, 2008-01-30 at 07:16 +0100, Stefan Roese wrote:
>>> On Wednesday 16 January 2008, Josh Boyer wrote:
>>>> On Wed, 16 Jan 2008 20:53:59 +1100
>>>>
>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>>> On Wed, 2008-01-16 at 10:37 +0100, Stefan Roese wrote:
>>>>>> With the removal the the "rgmii-interface" device_type property from
>>>>>> the dts files, the newemac driver needs an update to only rely on
>>>>>> compatible property.
>>>>>>
>>>>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>>>> I need to test if it works on CAB, can't change the DT on those. I'll
>>>>> let you know tomorrow.
>>>> This should be fine on CAB.  The rgmii node has:
>>>>
>>>> compatible = "ibm,rgmii-axon", "ibm,rgmii"
>>>>
>>>> so the match should still catch on the latter.
>>> How about this patch? Ben, if you think this is ok then we should make sure 
>>> that it goes in in this merge-window, since the other dts patch relies on it.
>> It's fine.
> 
> Jeff, any chance this can get into .25 soon?  I have another patch
> queued up behind this one that requires it, and I don't see it in any
> of your trees or branches.
> 
> Or, if you aren't opposed, I can take it through Paul's tree with your
> Ack.

can you resend?  I don't see it in the pile
