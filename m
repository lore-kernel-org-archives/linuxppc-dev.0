Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33265DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 20:44:41 +1000 (EST)
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A8C1399@zch01exm27.fsl.freescale.net>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-2-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-3-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-4-git-send-email-Jason.jin@freescale.com>
	<79f7e810cc79d5912587296c4f44b419@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A8C1399@zch01exm27.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d731595be98f00bf5387444b88de4883@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] booting-without-of for Freescale MSI
Date: Tue, 6 May 2008 12:44:22 +0200
To: "Jin Zhengxiong" <Jason.Jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +    - compatible : should be "fsl,MPIC-MSI" for 85xx/86xx cpu,
>>> +      and "fsl,IPIC-MSI" for 83xx cpu.
>>
>> Please use a more specific name, "fsl,8599-msi" or similar?
>>
>
> Thanks for your input. I think the name "fsl,MPIC-MSI" and
> "fsl,IPIC-MSI"
> is somethind specific.

This is the third MSI-on-MPIC I've seen, and I doubt it will be the
last.  It is likely FSL will make some different one in the future,
as well.

Please don't use generic names for specific devices.


Segher
