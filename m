Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABDABDDF2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jun 2008 03:02:30 +1000 (EST)
Message-ID: <485FD712.8010500@freescale.com>
Date: Mon, 23 Jun 2008 12:02:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: zhanglei459 <zhanglei459@gmail.com>
Subject: Re: how to understand pci section in device tree source file
References: <18070474.post@talk.nabble.com>
In-Reply-To: <18070474.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

zhanglei459 wrote:
> I guess  which refer to host-pci bridge ATMU,is right?

Yes.

> But how to descripe
> added-on pci chip,whose BAR0 and BAR1 are IO spaces, BAR2 and BAR3  are MEM
> spaces.

You don't need to -- this can be probed at run-time.

-Scott
