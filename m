Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7681DE1AE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jun 2008 01:02:23 +1000 (EST)
Message-ID: <485BC678.3060206@freescale.com>
Date: Fri, 20 Jun 2008 10:02:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Nidhi Dua <dua.nidhi2007@gmail.com>
Subject: Re: u-boot, MPC8313erdb
References: <d8b992c20806200752k6745b917w5d45efee440778fa@mail.gmail.com>
In-Reply-To: <d8b992c20806200752k6745b917w5d45efee440778fa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Nidhi Dua wrote:
> question 3: After we have set 'ethact' to TSEC1, the kernel is loaded, 
> and we have logged -in, when we try to ping the Host from target it says 
> '100% packet lost'. also we are unable to ping target from the host. Why 
> is it happening so?

U-boot does not support responding to pings.

Also, please use the u-boot-users list for u-boot questions, use a more 
descriptive subject, and don't repost the same question multiple times.

-Scott
