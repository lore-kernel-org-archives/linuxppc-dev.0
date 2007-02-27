Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4787EDDD0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 05:53:48 +1100 (EST)
In-Reply-To: <29DC34A6B43468409F5A371CFE34E8490B614F@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E8490B614F@ex01.ads.ubidyne.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <CB39D235-9A02-4FB3-B19E-D7928F0E44E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Could not create MTD Partitions
Date: Tue, 27 Feb 2007 12:52:54 -0600
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
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


On Feb 27, 2007, at 3:48 AM, Frank Prepelica wrote:

> Hi all,
>
>
>
> I got a problem during creating the MTD partitions. I=92m using the
>
> ELDK 4.1 with 2.6.19.2 Kernel and the MPC8343 board with 128MB RAM
>
> and 64MB flash memory.

Are you sure its a single flash chip that is 64M or multiple flash =20
chips?

- k
