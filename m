Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 0E24767A72
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 23:45:16 +1000 (EST)
Message-ID: <4246B8E6.4060401@varma-el.com>
Date: Sun, 27 Mar 2005 17:45:10 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>, Dale Farnsworth <dale@farnsworth.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
In-Reply-To: <0.20050327_004704.tnt@patchsend.246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: [PATCH 0/6] Change MPC52xx to platform bus / ppc_sys model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain, Dale

Which state of fec ocp -> fec platform conversion?
Without fec, IMHO, this patches less usable.

-- 
Regards
Andrey Volkov

Sylvain Munaut wrote:
> Hi Andrew,
> 
> This series of patch changes all the MPC52xx related code
> to use platform bus and ppc_sys instead of OCP. It's
> divided in several patches that represents "steps" in
> the conversion. However the intermediate states might
> not be functionnal.
> 
> Theses are against a bk clone of this morning since they
> depend on some patches that are on bk but not yet in
> 2.6.12-rc1. I just tested and they also apply/run fine
> with -mm3.
> 
> 
> Regards,
> 
> 	Sylvain
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
