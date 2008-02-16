Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-106-saturday.noc.nerim.net
	[62.4.17.106]) by ozlabs.org (Postfix) with ESMTP id CC19FDDE9A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 19:20:24 +1100 (EST)
Date: Sat, 16 Feb 2008 09:20:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/2] i2c-ibm_iic driver
Message-ID: <20080216092020.2a37e2d3@hyperion.delvare>
In-Reply-To: <47B66179.9010501@pikatech.com>
References: <4784FED1.2040206@pikatech.com> <47A14E23.50807@pikatech.com>
	<20080214094516.1b958ae4@hyperion.delvare>
	<47B66179.9010501@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 Feb 2008 23:07:21 -0500, Sean MacLennan wrote:
> Jean Delvare wrote:
> > Please split your patch into logical parts:
> > * Whitespace and coding-style cleanups
> > * Other cleanups (e.g. changing the log levels)
> > * Add OF support
> >   
> Here is the first patch with everything except the OF support. Really 
> all I did was change the log levels based on feedback from linxppc-dev.
> 
> Cheers,
>    Sean
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

Applied, thanks.

-- 
Jean Delvare
