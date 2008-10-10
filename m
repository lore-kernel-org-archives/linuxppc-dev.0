Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70FACDDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:42:28 +1100 (EST)
Message-Id: <EA71A3A9-4137-490D-82BB-9817D3D4E01C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40810080915v38a1c40cs7cac3825ee5a7bac@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/3] powerpc: 5121: Add PCI support.
Date: Thu, 9 Oct 2008 22:42:19 -0500
References: <1223413998-15577-1-git-send-email-jrigby@freescale.com>
	<4800D7D4-28BC-435A-9858-8FAF41F38468@kernel.crashing.org>
	<fa686aa40810080915v38a1c40cs7cac3825ee5a7bac@mail.gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2008, at 11:15 AM, Grant Likely wrote:

> On Wed, Oct 8, 2008 at 6:38 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> On Oct 7, 2008, at 4:13 PM, John Rigby wrote:
>>
>>> Uses mpc83xx_add_bridge in fsl_pci.c
>>>
>>> Adds second register tuple to pci node register property
>>> as done for 83xx device trees in a previous patch.
>>>
>>> Signed-off-by: John Rigby <jrigby@freescale.com>
>>> ---
>>> arch/powerpc/boot/dts/mpc5121ads.dts      |    3 ++-
>>> arch/powerpc/platforms/512x/Kconfig       |    2 ++
>>> arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++++++++
>>> arch/powerpc/sysdev/fsl_pci.c             |    4 ++--
>>> 4 files changed, 16 insertions(+), 3 deletions(-)
>>
>> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

applied

- k
