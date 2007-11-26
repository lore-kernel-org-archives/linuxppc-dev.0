Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id A71BEDDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 06:42:44 +1100 (EST)
Message-ID: <474B21B1.7020809@qstreams.com>
Date: Mon, 26 Nov 2007 14:42:41 -0500
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: fabio777@gmail.com
Subject: Re: SPI driver for spi_mpc83xx
References: <4749310D.1090008@gmail.com>
In-Reply-To: <4749310D.1090008@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

fabio777 wrote:
> Has anyone been using this driver ?
>   
I use it, on ARCH=powerpc, though.
> For legacy reasons I need to keep the ppc=arch however I haven't found 
> out how to get this driver probed at start-up even basing my init on 
> Lublock.
>
>   
The driver's expecting a platform device with name "mpc83xx_spi" to be 
registered in board init code. If you post your init code I may be able 
to help.

regards,
Ben
