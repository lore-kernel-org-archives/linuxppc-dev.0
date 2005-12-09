Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43C7C688C3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Dec 2005 02:21:31 +1100 (EST)
In-Reply-To: <200512091453.13544.sr@denx.de>
References: <20051130070059.28442.qmail@web50609.mail.yahoo.com>
	<200512011430.48271.sr@denx.de>
	<DD6BF3D1-45C9-4F47-AA10-82119C6BB993@kernel.crashing.org>
	<200512091453.13544.sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1934632A-C992-46D5-A498-1A0E5788D344@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 9 Dec 2005 09:21:23 -0600
To: Stefan Roese <sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: Add TQM85xx (8540/8541/8555/8560) board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 9, 2005, at 7:53 AM, Stefan Roese wrote:

> Hi Kumar,
>
> On Thursday 08 December 2005 08:13, Kumar Gala wrote:
>> Had a question on this, any reason you have to hookup the rtc with an
>> late_initcall()?
>
> Yes, because it's an I2C RTC. It's already done this way on some other
> platforms. Are there some problems with this late_initcall()?

No, just wondering.

- kumar
