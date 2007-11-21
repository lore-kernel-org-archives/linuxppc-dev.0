Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 301C4DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:01:28 +1100 (EST)
Message-Id: <56B46498-9213-49A1-B667-40B286291461@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF029708189001A1C7DF@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 3/9] add Freescale SerDes PHY support
Date: Tue, 20 Nov 2007 22:01:14 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<fa686aa40710190835t4329d52bt74fb3b8f30b25847@mail.gmail.com>
	<68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
	<989B956029373F45A0B8AF029708189001A1C7DF@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Upon further review of all this I don't think this belongs in
>> the kernel at all.  This is one time setup and should be done
>> in firmware.
>
> I'm ok for it to be taken care of in u-boot for now.  However, if we
> later plan to add power management support to this block.  We probably
> have to do it in kernel.

How does pwr mgmt come into play w/SerDes?

- k
