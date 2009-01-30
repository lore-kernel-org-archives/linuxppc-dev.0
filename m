Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCD1ADE1C8
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 01:42:53 +1100 (EST)
Message-Id: <F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <4982F311.4050507@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
Date: Fri, 30 Jan 2009 08:42:39 -0600
References: <4982F311.4050507@gefanuc.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2009, at 6:31 AM, Martyn Welch wrote:

> Hi Guys,
>
> It seems that 2.6.29-rc3 is not booting on the MPC8641 HPCN. I have  
> just updated u-boot to the latest git to see if that improved  
> matters, however I get stuck at the following. Any ideas?

did you update your .dtb as well?

- k
