Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F111BDDF85
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 02:10:34 +1000 (EST)
Message-ID: <48593373.1010406@freescale.com>
Date: Wed, 18 Jun 2008 11:10:27 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Eric Witcher <witcher@mindspring.com>
Subject: Re: Question regarding mpic_assign_isu() in storcenter.c
References: <21800186.1213747779368.JavaMail.root@mswamui-cedar.atl.sa.earthlink.net>
In-Reply-To: <21800186.1213747779368.JavaMail.root@mswamui-cedar.atl.sa.earthlink.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric Witcher wrote:
> The answer is that mpic_assign_isu(mpic, 1, paddr + 0x11000) places the initial base register
> for isu 1 on a reserved location in the PIC register map (see *).  I guess you can infer from this
> that no badness occurs when you write to a reserved location on the PIC.

See?  See Kumar?  Didn't you tell me that would
come back to haunt us juuust like you said... :-)

jdl
