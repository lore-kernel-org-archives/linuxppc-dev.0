Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58BD0DDF0E
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 02:08:51 +1100 (EST)
Message-ID: <47878674.7010705@freescale.com>
Date: Fri, 11 Jan 2008 09:08:36 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [alsa-devel] [PATCH v2] [ALSA] Add ASoC drivers for the	Freescale
	MPC8610 SoC
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
	<4786A650.2080107@freescale.com> <20080111002450.GA13291@lixom.net>
In-Reply-To: <20080111002450.GA13291@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> Having been in a similar situation myself (needing to share resources
> between DMA, ethernet and function offload), I recommend creating a
> separate small library that all those drivers use, instead of making
> some sort of dependency between drivers in completely different parts
> of the kernel.

Well, the DMA driver should be in soon.  Actually, it should be in now, because 
I saw a blurb in this month's Linux Journal about it.  As soon as I find it :-), 
I'll post a new patch that adds arbitration.

-- 
Timur Tabi
Linux kernel developer at Freescale
