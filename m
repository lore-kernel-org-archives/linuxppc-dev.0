Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EC9E67B93
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 07:50:51 +1000 (EST)
In-Reply-To: <200608032101.23547.sshebbar@gmail.com>
References: <DD0740E2135CA545B541AC5F60170AB4F56867@az33exm21.fsl.freescale.net>
	<200608032101.23547.sshebbar@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <22237B2A-9FD3-48AB-998A-DD8448A51B74@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: USB problem on MPC8349 (MPH0-ULPI)
Date: Thu, 3 Aug 2006 16:50:49 -0500
To: Srinivasa Hebbar <sshebbar@gmail.com>
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


On Aug 3, 2006, at 10:31 AM, Srinivasa Hebbar wrote:

>
> Hello,
>
> On MPC8349 sys board, I am getting following error when
> I connect the USB mass storage device.
>
> I am using MPH0 in ULPI mode.
>
> The driver doesn't detect any USB device.
>
> Any help to solve this problem is appreciated.
>
> The configuration and details of the board is given at
> the end of this mail.

[snip]

>> Operating System: Linux 2.6.11 (Freescale BSP downloaded from
>> metrowerks/freescale website).

I'd suggest using a stock 2.6.17 kernel or take the issue up with  
Freescale since you are running a kernel from them.

- kumar
