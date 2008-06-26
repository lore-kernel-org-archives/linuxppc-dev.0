Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AEC2DE237
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 07:45:27 +1000 (EST)
Message-ID: <48640DB1.7020500@freescale.com>
Date: Thu, 26 Jun 2008 16:44:17 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: monstr@seznam.cz
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-2-git-send-email-monstr@seznam.cz>	<1214483429-32360-3-git-send-email-monstr@seznam.cz>	<1214483429-32360-4-git-send-email-monstr@seznam.cz>	<1214483429-32360-5-git-send-email-monstr@seznam.cz>	<1214483429-32360-6-git-send-email-monstr@seznam.cz>	<1214483429-32360-7-git-send-email-monstr@seznam.cz>	<1214483429-32360-8-git-send-email-monstr@seznam.cz>	<1214483429-32360-9-git-send-email-monstr@seznam.cz>	<1214483429-32360-10-git-send-email-monstr@seznam.cz>	<1214483429-32360-11-git-send-email-monstr@seznam.cz>	<1214483429-32360-12-git-send-email-monstr@seznam.cz>	<1214483429-32360-13-git-send-email-monstr@seznam.cz><4863B096.7020309@freescale.com>	<4863E68C.30802@seznam.cz>
	<20080626201813.9662411E0051@mail20-wa4.bigfish.com>
	<48640CF7.7050700@seznam.cz>
In-Reply-To: <48640CF7.7050700@seznam.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	vapier.adi@gmail.com, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John Linn <linnj@xilinx.com>, drepper@redhat.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michal Simek wrote:
> Ok. Thanks for information Steve.
> 
> Jon: Only for sure the main difference is only in value handling. Am I right?
> If yes, it is easy to change.
> 
> M

Right.  It is essentially C-like now.  And has a
declarator at the top with /dts-v1/.  Essentially
all of the DTS files in arch/powerpc/boot/dts should
be V1 now.  Lots of examples.

Except in Byte Arrays:  x = [ CA FE BA BE FE ED D0 0D ];

jdl
