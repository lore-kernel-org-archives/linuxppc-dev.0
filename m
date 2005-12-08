Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D6BF688BE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 18:14:02 +1100 (EST)
In-Reply-To: <200512011430.48271.sr@denx.de>
References: <20051130070059.28442.qmail@web50609.mail.yahoo.com>
	<15EF7506-D65A-4FD0-9042-A5133D8B7C65@kernel.crashing.org>
	<200512011430.48271.sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DD6BF3D1-45C9-4F47-AA10-82119C6BB993@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 8 Dec 2005 01:13:54 -0600
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

On Dec 1, 2005, at 7:30 AM, Stefan Roese wrote:

> This patch adds support for the TQ Components TQM85xx modules.  
> Currently the
> modules TQM8540/8541/8555/8560 are supported.
>
> Signed-off-by: Stefan Roese <sr@denx.de>
>
> Best regards,
> Stefan
> <add-tqm85xx-board-support-2.patch>

Had a question on this, any reason you have to hookup the rtc with an  
late_initcall()?

- kumar
