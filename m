Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6DEEEDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 07:02:58 +1100 (EST)
From: Marvin <marvin24@gmx.de>
To: Fabiano Manoel de Andrade <fabianoma@gmail.com>
Subject: Re: RTC problem in PS3
Date: Mon, 17 Nov 2008 21:02:11 +0100
References: <1226875490.6597.11.camel@lottar>
In-Reply-To: <1226875490.6597.11.camel@lottar>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811172102.12286.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

forward to a better place...

On Sunday 16 November 2008 23:44:50 Fabiano Manoel de Andrade wrote:
> 	Hi I've compiled the latest version of linux kernel (2.6.27.6) in my
> PS3 running debian and get a warning message listed here
>
> 	Setting the system clock.
>   	Cannot access the Hardware Clock via any known method.
>   	Use the --debug option to see the details of our search for an access
> method. * Unable to set System Clock to: Sun Nov 16 20:33:06 UTC 2008
>
>
> 	The problem can be reproduced with the commands
>
> 	# hwclock --debug
>  	hwclock from util-linux-ng 2.13.1.1
>   	hwclock: Open of /dev/rtc failed, errno=2: No such file or directory.
>   	No usable clock interface found.
>   	Cannot access the Hardware Clock via any known method.
>   	# ls -l /dev/rtc*
>   	ls: cannot access /dev/rtc*: No such file or directory
>
> 	Loading the rtc-ppc module solve the problem, but after restart
> the system I still have the problem. Looking at kernel config I change the
> rtc-ppc to be build into kernel and this solve totally the problem. So the
> ps3_defconfig must set the rtc-ppc to be build into kernel.
>
> 	Thanks in advance.
> 	Fabiano.
