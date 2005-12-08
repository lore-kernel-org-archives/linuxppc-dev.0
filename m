Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 549956884E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 00:40:38 +1100 (EST)
Message-ID: <439837D4.7090304@ru.mvista.com>
Date: Thu, 08 Dec 2005 16:40:36 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Matthew McClintock <msm@freescale.com>
References: <438B379B.6090904@ru.mvista.com>
	<1133848163.7932.2.camel@localhost.localdomain>
In-Reply-To: <1133848163.7932.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Adds MPC885ADS, MPC866ADS and	MPC8272ADS-specific
 platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt,
Matthew McClintock wrote:
> On Mon, 2005-11-28 at 10:00 -0700, Vitaly Bordug wrote:
>> +       mpc82xx_fcc1_pdata.dpram_offset =
>> mpc82xx_fcc2_pdata.dpram_offset = (u32)cpm2_immr->im_dprambase;
>> +       mpc82xx_fcc1_pdata.fcc_regs_c = mpc82xx_fcc2_pdata.fcc_regs_c
>> = (u32)cpm2_immr->im_fcc_c; 
> 
> I'm not sure if this has already been discussed, but what is stopping us
> from including this in the platform definition files along with the
> other offsets?
IIRC, because these values could vary along the PQ2 family, when all the stuff in pq2_devices.c should be static and applicable to any PQ2 which does have the corresponding device.
> 
> -Matthew
> 
> 


-- 
Sincerely, 
Vitaly
