Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFBCBDDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 06:45:15 +1000 (EST)
In-Reply-To: <1187900581.28951.17.camel@ld0161-tx32>
References: <1185560634.8055.170.camel@ld0161-tx32>
	<1187900581.28951.17.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CF601BCB-6F43-4CE2-A70B-0790DDBB19F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Remove unnecessary loops_per_jiffy initialization code
Date: Thu, 23 Aug 2007 15:47:14 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2007, at 3:23 PM, Jon Loeliger wrote:

> On Fri, 2007-07-27 at 13:23, Jon Loeliger wrote:
>> This patch series removes lingering jiffies initialization
>> code from several platforms.  Note that the first patch in
>> this series for the 86xx has been rebased to current top of
>> Paul's repository and replaces an earlier version.
>>
>>
>>  arch/powerpc/platforms/52xx/lite5200.c         |   13 ++-----------
>>  arch/powerpc/platforms/85xx/mpc85xx_ads.c      |   13 -------------
>>  arch/powerpc/platforms/85xx/mpc85xx_cds.c      |   13 -------------
>>  arch/powerpc/platforms/85xx/mpc85xx_mds.c      |   11 -----------
>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |   14 ++------------
>>  arch/powerpc/platforms/8xx/mpc86xads_setup.c   |   14 --------------
>>  arch/powerpc/platforms/8xx/mpc885ads_setup.c   |   14 --------------
>>  arch/powerpc/platforms/embedded6xx/holly.c     |   12 ------------
>>  arch/powerpc/platforms/embedded6xx/prpmc2800.c |    7 -------
>>  9 files changed, 4 insertions(+), 107 deletions(-)
>
> Kumar,
>
> Any reason why patches 1/5 and 2/5, for 86xx and 85xx respectively,
> did not get applied and ushered upstream with the others?

No, I'm glad you said something cause I assumed paul grabbed them all.

I'll grab them in my tree once I beat paul into pulling the include  
fixup changes.

- k
