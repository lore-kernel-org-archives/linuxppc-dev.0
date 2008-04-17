Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23BFFDE0BE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 23:26:31 +1000 (EST)
Message-Id: <B9622B0A-92E6-4787-8C5E-F54982F10556@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF02970818900200750D@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch to the cpm_muram
	implementation
Date: Thu, 17 Apr 2008 08:26:12 -0500
References: <20080320173945.GA8446@localhost.localdomain><20080414181810.GA1038@polina.dev.rtsoft.ru>
	<20080416182214.GA20056@polina.dev.rtsoft.ru>
	<989B956029373F45A0B8AF02970818900200750D@zch01exm26.fsl.freescale.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wood Scott <scottwood@freescale.com>, Jeff Garzik <jgarzik@pobox.com>,
	Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2008, at 10:38 PM, Li Yang wrote:
>> -----Original Message-----
>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org]
>> On Behalf Of Anton Vorontsov
>> Sent: Thursday, April 17, 2008 2:22 AM
>> To: Kumar Gala
>> Cc: Wood Scott; linuxppc-dev@ozlabs.org; Jeff Garzik; Tabi
>> Timur; netdev@vger.kernel.org
>> Subject: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch to
>> the cpm_muramimplementation
>>
>> This is very trivial patch. We're transitioning to the
>> cpm_muram_* calls. That's it.
>
> Hi Anoton,
>
> It is a good thing to unify the CPM dpram operation and QE muram  
> operation.  But I'm having concerns about the naming as CPM is an  
> obsolete block.  Can we change to use the new name QE instead?

or at least provide both names by a simple:

#define qe_muram_addr cpm_muram_addr

- k
