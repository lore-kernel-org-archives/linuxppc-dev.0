Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A992DE0CD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:14:29 +1100 (EST)
Message-ID: <4786A650.2080107@freescale.com>
Date: Thu, 10 Jan 2008 17:12:16 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2] [ALSA] Add ASoC drivers for the	Freescale
	MPC8610 SoC
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
In-Reply-To: <fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Does the driver access the DMA and GUTS registers directly?  If so,
> what do you have to protect against race conditions of other drivers
> accessing them also.

I don't have any more protection than any other driver that accesses SOC 
registers directly.  Last I heard, Zhang's DMA driver was in limbo, and that 
driver would be the best place to arbitrate DMA register access.  I was planning 
on adding arbitration support to that driver after both drivers were applied.

As for the GUTS driver, well, I just program a few registers at startup, and I 
don't think any other driver touches them.

-- 
Timur Tabi
Linux kernel developer at Freescale
