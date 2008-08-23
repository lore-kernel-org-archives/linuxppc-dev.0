Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1468DDDDC
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 00:41:41 +1000 (EST)
Message-Id: <7B78E4ED-3722-4944-9EB5-58397B9513A8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080822171135.GA15623@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Date: Sat, 23 Aug 2008 09:41:28 -0500
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
	<72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
	<20080822121152.70f01597.martyn.welch@gefanuc.com>
	<20080822122601.162dddd4.martyn.welch@gefanuc.com>
	<20080822171135.GA15623@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Martyn Welch <martyn.welch@gefanuc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2008, at 12:11 PM, Scott Wood wrote:

> On Fri, Aug 22, 2008 at 12:26:01PM +0100, Martyn Welch wrote:
>>>> drop device_type.
>>>>
>>>
>>> Ah - _all_ device_type!
>>>
>>
>> Um, not all - just the ones where the name of the block matches the
>> device type(?)
>
> All except "cpu" and "memory".

I think "network" is ok.

- k
