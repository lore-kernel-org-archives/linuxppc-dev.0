Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id CA52067A76
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 08:44:00 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 1so345095rny
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 13:43:57 -0800 (PST)
Message-ID: <c3d0340b05022413437aa5b729@mail.gmail.com>
Date: Thu, 24 Feb 2005 13:43:57 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050223142426.B13087@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
	<20050223142426.B13087@cox.net>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Ebony's UBoot awareness
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

> Can you use the ocotea/luan approach and create an openbios stub
> in arch/ppc/boot to create the bi_enetaddr infos? The PIBS stub
> in arch/ppc/boot does this so we can have one path in the platform
> file that parses the bootinfos.

I'd like to help if I can follow you. What does PIBS stand for? What
is the ocotea/luan approach you were talking about? I thought I
followed the ocotea approach to set up mac addresses.

Thanks,
-Shawn.
