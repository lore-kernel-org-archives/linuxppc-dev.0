Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81BA51007E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 11:55:58 +1100 (EST)
Date: Tue, 8 Mar 2011 16:55:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Message-Id: <20110308165531.92c09a8a.akpm@linux-foundation.org>
In-Reply-To: <20110303092239.GB3649@pengutronix.de>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110303092239.GB3649@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: a.zummo@towertech.it, linuxppc-dev@lists.ozlabs.org,
	Priyanka Jain <Priyanka.Jain@freescale.com>,
	rtc-linux@googlegroups.com, p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 3 Mar 2011 10:22:39 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Hi,
> 
> > +/*
> > + * This file provides Date & Time support (no alarms) for PT7C4338 chip.
> > + *
> > + * This file is based on drivers/rtc/rtc-ds1307.c
> 
> Please explain why you can't use rtc-ds1307 directly (or with slight
> modifications). I might have missed something but the register-set looks
> identical to me?
> 

Was there an answer to this question?

Thanks.
