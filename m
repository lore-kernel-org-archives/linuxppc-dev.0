Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B04EEDE132
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:25:43 +1000 (EST)
Message-ID: <49E78620.7070303@freescale.com>
Date: Thu, 16 Apr 2009 14:25:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: issues w/init
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
In-Reply-To: <88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> [root:~] cat /proc/1/maps
> 00100000-00103000 r-xp 00100000 00:00 0          [vdso]
> 0feab000-0ffbe000 r-xp 00000000 00:0d 7127086    /lib/libc-2.2.5.so
> 0ffbe000-0ffcb000 ---p 00113000 00:0d 7127086    /lib/libc-2.2.5.so
> 0ffcb000-0ffeb000 rw-p 00110000 00:0d 7127086    /lib/libc-2.2.5.so

IIRC, this libc is old enough to execute out of non-exec memory in some 
cases.

-Scott
