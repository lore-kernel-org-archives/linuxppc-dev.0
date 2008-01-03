Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A6D7DDF52
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 04:58:58 +1100 (EST)
Message-ID: <477D2255.3040803@freescale.com>
Date: Thu, 03 Jan 2008 11:58:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: suja Baburaj <sujababuraj@gmail.com>
Subject: Re: MPC8260ADS and linux-2.6
References: <a3b98ac10801022105w240b0f96race4d3aa84e51f27@mail.gmail.com>
In-Reply-To: <a3b98ac10801022105w240b0f96race4d3aa84e51f27@mail.gmail.com>
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

suja Baburaj wrote:
> I have an MPC8260ADS board with (eldk)linux-2.4.25 working fine on it.
> Now i want to try linux-2.6.X on the board.

There's no support for that specific board in mainstream 2.6 yet, but it 
should be fairly simple to get it working using the mpc8272ads support 
as an example.

-Scott
