Return-Path: <pku.leo@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.237])
	by ozlabs.org (Postfix) with ESMTP id BBDAEDE0B4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 16:52:16 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id a16so4449236qbd.39
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 21:52:14 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <C37C3C8D-0DAA-4174-9A19-E2983CD32380@kernel.crashing.org>
References: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
	<3A45394FD742FA419B760BB8D398F9ED13DD10@zch01exm26.fsl.freescale.net>
	<C37C3C8D-0DAA-4174-9A19-E2983CD32380@kernel.crashing.org>
Date: Tue, 13 Jan 2009 13:52:14 +0800
Message-ID: <2a27d3730901122152q33580942se37c5bb8d515ddbc@mail.gmail.com>
Subject: Re: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB
	w/FSL U-Boots
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2009 at 11:07 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jan 12, 2009, at 1:55 AM, Li Yang wrote:
>
>>> -----Original Message-----
>>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org]
>>> On Behalf Of Anton Vorontsov
>>> Sent: Sunday, January 11, 2009 11:30 PM
>>> To: Kumar Gala
>>> Cc: linuxppc-dev@ozlabs.org
>>> Subject: [PATCH] powerpc/83xx: Make serial ports work on
>>> MPC8315E-RDB w/FSL U-Boots
>>>
>>> FSL U-Boots use /soc8315@e0000000 node to search and fixup
>>> serial nodes' clock-frequency properties. Though in upstream
>>> kernels we use new naming convention -- for IMMR address
>>> space dts files specify /immr@e0000000 nodes.
>>>
>>> This makes FSL U-Boots fail to fixup the clock frequencies,
>>> and that leads to serial ports misbehaviour. We can
>>> workaround the issue by filling the clock frequency values manually.
>>
>> Freescale BSP is for customer who needs the out-of-box experience.  It's
>> better tested, but doesn't update very frequently.  I would suggest the
>> customer to use the upstream u-boot, if they decide to use latest
>> upstream kernel.
>>
>> - Leo
>
> Agreed.  However I don't think there is any harm w/the patch as upstream
> u-boot will update the property.

You are right.   There will be no harm as upstream u-boot can update
the DTS of old binding.

- Leo
