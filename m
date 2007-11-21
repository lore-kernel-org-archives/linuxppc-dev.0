Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2E90DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 04:22:05 +1100 (EST)
Message-ID: <474468C5.8080402@freescale.com>
Date: Wed, 21 Nov 2007 11:20:05 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Firmware Support for USB Hub
References: <13877282.post@talk.nabble.com>
In-Reply-To: <13877282.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah khan wrote:
> Hi all,
> 
> I am using a 8248 processor which has a USB controller and i need to connect
> a USB Hub to it, iam using Montavista Linux .I need to know that what are
> the support i need form Montavista or Open source to have an interface with
> Usb hub. ???
> 
> Is there any driver that we need to make if so what type ???

I don't believe a driver currently exists for CPM USB.

-Scott
