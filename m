Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AFDFDDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 14:32:09 +1100 (EST)
Message-Id: <68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <fa686aa40710190835t4329d52bt74fb3b8f30b25847@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 3/9] add Freescale SerDes PHY support
Date: Tue, 20 Nov 2007 21:31:59 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<fa686aa40710190835t4329d52bt74fb3b8f30b25847@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 10:35 AM, Grant Likely wrote:

> On 10/19/07, Li Yang <leoli@freescale.com> wrote:
>> The SerDes(serializer/deserializer) PHY block is a new SoC block used
>> in Freescale chips to support multiple serial interfaces, such as PCI
>> Express, SGMII, SATA.
>
> This looks like board setup behaviour.  Shouldn't setting this up be
> the responsibility firmware?  And failing that, I think it should be
> done directly by the platform setup function (in other words; make it
> a helper function and call it at board setup time).  Besides, you want
> to provide guarantees that the board is setup correctly before the
> device driver that uses it gets probed.
>
> Cheers,
> g.

Upon further review of all this I don't think this belongs in the  
kernel at all.  This is one time setup and should be done in firmware.

- k
