Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id EEF1E67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 19:02:19 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 40so29715rnz
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 00:02:05 -0800 (PST)
Message-ID: <c3d0340b050223000217714e92@mail.gmail.com>
Date: Wed, 23 Feb 2005 00:02:04 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050223042234.GA31255@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <c3d0340b050222190712ee7dff@mail.gmail.com>
	<20050223042234.GA31255@gate.ebshome.net>
Subject: Re: Ethernet doesn't work in linux for PPC440GP?
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

> > zmii0: input 0 in SMII mode
> > eth0: IBM emac, MAC 00:04:ac:e3:1b:bb
> > eth0: Found Generic MII PHY (0x08)
> > zmii0: input 1 in RMII mode
> > eth1: IBM emac, MAC FF:FF:FF:FF:FF:FF
> > eth1: Found Generic MII PHY (0x09)
> 
> I already told you that this is wrong, why are you asking again?
> Please, if you asking questions, spend some time reading answers
> given to you, before asking again.

Well, don't be mad at me first. The question may bring out another
round of arguments whether it's a bug related to uboot or linux EMAC
driver. Wolfgang makes it very clear that this is a bug in linux
ethernet driver. And I agree with him. This argument happened before
and I just forgot what specific ethernet driver was in the argument.

> Ebony uses RMII, so SMII is obviously wrong. Most probably your
> firmware doesn't set correct mode and autodetection in the EMAC driver
> fails.

So the EMAC driver does expect a boot loader (the firmware you
mentioned here) to set something for it. Then I think I need to fix it
in this driver instead of in uboot.

-Shawn.
