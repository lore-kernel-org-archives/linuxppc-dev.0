Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84856688B6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 03:14:22 +1100 (EST)
In-Reply-To: <439837D4.7090304@ru.mvista.com>
References: <438B379B.6090904@ru.mvista.com>
	<1133848163.7932.2.camel@localhost.localdomain>
	<439837D4.7090304@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <377ECD64-43EF-423D-94BC-8EAE57319892@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 8 Dec 2005 10:14:07 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Adds MPC885ADS,
	MPC866ADS and	MPC8272ADS-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 8, 2005, at 7:40 AM, Vitaly Bordug wrote:

> Matt,
> Matthew McClintock wrote:
>> On Mon, 2005-11-28 at 10:00 -0700, Vitaly Bordug wrote:
>>> +       mpc82xx_fcc1_pdata.dpram_offset =
>>> mpc82xx_fcc2_pdata.dpram_offset = (u32)cpm2_immr->im_dprambase;
>>> +       mpc82xx_fcc1_pdata.fcc_regs_c =  
>>> mpc82xx_fcc2_pdata.fcc_regs_c
>>> = (u32)cpm2_immr->im_fcc_c;
>> I'm not sure if this has already been discussed, but what is  
>> stopping us
>> from including this in the platform definition files along with the
>> other offsets?
> IIRC, because these values could vary along the PQ2 family, when  
> all the stuff in pq2_devices.c should be static and applicable to  
> any PQ2 which does have the corresponding device.

How much variation is there?  I'm not sure how or why it would be  
different from how we handle the FEC and TSEC on 8540.

- kumar
