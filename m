Return-Path: <sr@denx.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 578876888C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Dec 2005 00:53:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 9 Dec 2005 14:53:13 +0100
References: <20051130070059.28442.qmail@web50609.mail.yahoo.com>
	<200512011430.48271.sr@denx.de>
	<DD6BF3D1-45C9-4F47-AA10-82119C6BB993@kernel.crashing.org>
In-Reply-To: <DD6BF3D1-45C9-4F47-AA10-82119C6BB993@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512091453.13544.sr@denx.de>
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

Hi Kumar,

On Thursday 08 December 2005 08:13, Kumar Gala wrote:
> Had a question on this, any reason you have to hookup the rtc with an
> late_initcall()?

Yes, because it's an I2C RTC. It's already done this way on some other 
platforms. Are there some problems with this late_initcall()?

Best regards,
Stefan
