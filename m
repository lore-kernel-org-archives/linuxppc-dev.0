Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D43ADDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:39:55 +1100 (EST)
Message-Id: <D6B23105-8FB1-452C-8BBF-D96B790B49D0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5863BE5F-95D7-499C-AFC4-C7ECE62847D4@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Convert MPC837x device trees to dts-v1
Date: Fri, 18 Jan 2008 00:39:46 -0600
References: <1199791957-5309-1-git-send-email-leoli@freescale.com>
	<5863BE5F-95D7-499C-AFC4-C7ECE62847D4@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 18, 2008, at 12:31 AM, Kumar Gala wrote:

>
> On Jan 8, 2008, at 5:32 AM, Li Yang wrote:
>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/boot/dts/mpc8377_mds.dts |  148 +++++++++++++++
>> +---------------
>> arch/powerpc/boot/dts/mpc8378_mds.dts |  140 ++++++++++++++
>> +---------------
>> arch/powerpc/boot/dts/mpc8379_mds.dts |  156 ++++++++++++++++
>> +----------------
>> 3 files changed, 225 insertions(+), 219 deletions(-)
>
> applied.

I dropped the "fsl,pq2pro-sata" compat prop.  We need to come up with  
something a bit more generic.

- k
