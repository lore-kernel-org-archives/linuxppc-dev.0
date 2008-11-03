Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E66B0DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 03:29:35 +1100 (EST)
Message-ID: <490F26C7.1000109@freescale.com>
Date: Mon, 03 Nov 2008 10:28:55 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH V2] powerpc: Fix Book-E watchdog timer interval setting
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<200809231704.56449.matthias.fuchs@esd-electronics.com>
	<ed82fe3e0809230931h10101b3csdc0187c19bac1529@mail.gmail.com>
	<200811030956.37948.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811030956.37948.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthias Fuchs wrote:
> Timur,
> 
> I missed you posting. But you are right. My patch is ok for 4xx CPUs and touching 
> the CONFIG_FSL_BOOKE path was not my intention.
> 
> So for CONFIG_FSL_BOOKE WDTP_MASK should be WDTP(0). There is still a slightly difference
> between WDTP(0)="(3 << 30) | (0x3c << 15)" and "(3 << 30) | (15 << 15)". 
> Can you check that please and I will resend my patch.

Yes, I think WDTP(0) is correct for Book E.

-- 
Timur Tabi
Linux kernel developer at Freescale
