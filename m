Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1A7BDDDE4
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 04:50:03 +1000 (EST)
Message-ID: <470535DF.30303@freescale.com>
Date: Thu, 04 Oct 2007 13:50:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: Console handover: tty0 instead of ttyCPM0?
References: <bfa0697f0710041146y2c74b9dcy3dd413934680ab10@mail.gmail.com>
In-Reply-To: <bfa0697f0710041146y2c74b9dcy3dd413934680ab10@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
> Do you know what would cause this?
> 
> I've configured a board to console off of SMC1 (ttyCPM0) and on 1
> board it works fine, however a new revision of the board I get the
> following result and lose the console.  Both boards have "exact"
> versions of the kernel and u-boot.
> 
>    BAD: console handover: boot [udbg0] -> real [tty0]
>    GOOD: console handover: boot [udbg0] -> real [ttyCPM0]
[snip]
> Linux/PowerPC load: root=/dev/nfs ip=192.168.10.45:::255.255.255.0::eth0 nfsroow

You really should turn on line wrap in your serial program...

> console handover: boot [udbg0] -> real [tty0]
[snip]

> Kernel command line: console=ttyCPM0,38400n8 root=/dev/nfs ip=192.168.10.49:::2

This one has console=ttyCPM0.  The other one doesn't (unless it was 
eaten by the lack of line wrap).

-Scott
