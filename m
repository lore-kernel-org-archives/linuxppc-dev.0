Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE75450292
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:08:24 +1000 (EST)
Message-ID: <4A01FC3F.7080004@freescale.com>
Date: Wed, 06 May 2009 16:08:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
References: <1241640919-4650-1-git-send-email-wd@denx.de>	<1241640919-4650-3-git-send-email-wd@denx.de>
	<fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
In-Reply-To: <fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: John Rigby <jrigby@gmail.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>>  #ifdef CONFIG_FS_ENET_HAS_FEC
>> +#ifdef CONFIG_FS_ENET_MPC5121_FEC
>> +       {
>> +               .compatible = "fsl,mpc5121-fec",
>> +               .data = (void *)&fs_fec_ops,
>> +       },
>> +#else
>>        {
>>                .compatible = "fsl,pq1-fec-enet",
>>                .data = (void *)&fs_fec_ops,
>>        },
>>  #endif
>> +#endif
> 
> Hmmm.  A lot of these #ifdefs in here.  Does this have a multiplatform
> impact?  Not to mention the fact that it's just plain ugly.  :-)

Multiplatform between 512x and 8xx is currently impossible for other 
reasons (512x and CPM2 is another matter).  That said, less ifdefs would 
be nice.

-Scott
