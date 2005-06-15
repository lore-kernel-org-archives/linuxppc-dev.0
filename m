Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id F394367B3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 00:25:56 +1000 (EST)
In-Reply-To: <42AFDEFE.2040508@ru.mvista.com>
References: <42AFDEFE.2040508@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2731d19a2e3b9413db32be59726a4c82@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 15 Jun 2005 09:25:52 -0500
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 15, 2005, at 2:55 AM, Vitaly Bordug wrote:

> Kumar,
> I assume this as a IMMR enumerating you promised to help with. Is it in
> the final state? And what was the reason of fcc_regs_c removal?
> I'm also going to change the files name to cpm2_.. .

Yes, I removed the fcc_regs_c since its not always true.  Please don't 
rename the file to cpm2_.  I think I'm going to end up renaming them to 
pq2_ since that is the most appropriate name.  I'd say we are about 80% 
the way to a final patch.

- kumar
