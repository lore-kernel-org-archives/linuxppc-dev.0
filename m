Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6C18C679EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 01:41:30 +1000 (EST)
In-Reply-To: <4289DBE9.9080002@anagramm.de>
References: <4289DBE9.9080002@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a659357b80a843e5eb3db2ebd5ec3c53@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 17 May 2005 10:41:22 -0500
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: What ethernet driver to use in 2.6.8.1 instead of gianfar in
	2.6.11.x?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 17, 2005, at 6:56 AM, Clemens Koller wrote:

> Hello, again,
>
> for some tests and glibc-builds I want to work with a 2.6.8.1 kernel
>  temporarily on a freescale mpc8540.

Out of interest, what issues did you have with 2.6.11.x?

> In 2.6.8.1 there was no gianfar ethernet driver. Is it okay to use the
>  fec drivers instead of the gianfar or is it better to put the gianfar
>  drivers back into 2.6.8.1? (100Mbps are okay for that testing)

I doubt fec drivers would ever work for the TSECs.  You should be able 
to pull the driver code out of 2.6.11.x for gianfar back into 2.6.8.1 
w/o any real issue.

> Maybe somebody can get me a working .config for 2.6.8.1 and mpc8540ads?

Can you start with the .config file that exists in the 2.6.11 ?

- kumar
