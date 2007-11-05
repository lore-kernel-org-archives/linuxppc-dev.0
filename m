Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62C33DDE37
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:14:33 +1100 (EST)
Message-ID: <472F77E2.1060305@freescale.com>
Date: Mon, 05 Nov 2007 14:06:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>	
	<472F6D5D.3030804@genesi-usa.com>	
	<9e4733910711051151p18311586h133ac70917714466@mail.gmail.com>	
	<472F754C.1090202@freescale.com>
	<9e4733910711051204g1efd2911sffbeef956b9e9f01@mail.gmail.com>
In-Reply-To: <9e4733910711051204g1efd2911sffbeef956b9e9f01@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
>> Jon Smirl wrote:
>>> I can change it to remove fsl5200-clocking if someone can tell me if
>>> this is only needed on the mpc5200b.
>> Well, it appears to be needed on the mpc5200 (no 'b')...
> 
> What is the recommend way to check for a mpc5200 or mpc5200b?

Just check for mpc5200-i2c -- it's listed in the mpc5200b dts as well.

-Scott
